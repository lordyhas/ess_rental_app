import 'package:exploress_location/logic/map_data/maps.dart';
import 'package:exploress_location/src/myspace_page.dart';
import 'package:exploress_location/src/perference_page/about_page.dart';
import 'package:exploress_location/src/home_page.dart';
import 'package:exploress_location/src/login_page.dart';
import 'package:exploress_location/src/maps_test.dart';
import 'package:exploress_location/src/add_rent_page/add_rent_page.dart';
import 'package:exploress_location/src/home_page/shop_info_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:exploress_location/logic/values.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:exploress_location/on_404_page.dart';
import 'package:exploress_location/ongenerate_page.dart';
//import 'firebase_options.dart';

part 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: firebaseOptions);
  } else {
    await Firebase.initializeApp();
  }

  Bloc.observer = AppBlocObserver();

  /*final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
  //const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    //onSelectNotification: selectNotificationSubject.add,
    onDidReceiveBackgroundNotificationResponse: (response){},
    onDidReceiveNotificationResponse: (response){},
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );*/

  Hive.initFlutter();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) =>
      runApp(MyApp(authRepository: AuthenticationRepository())));
}




class MyApp extends StatelessWidget {
  const MyApp({
    required this.authRepository,
    Key? key,
  }) : super(key: key);

  final AuthenticationRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authRepository: authRepository,),
        child: EssRentApp(),
      ),
    );
  }
}

class EssRentApp extends StatelessWidget {
  EssRentApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  void _checkSomePermissions() async {
    if (kIsWeb) return;
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      //Permission.camera,
      //Permission.locationAlways,
    ].request();
    debugPrint("===== Permissions : ${statuses[Permission.storage]}");
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) _checkSomePermissions();

    return MultiBlocProvider(
      providers: [

        BlocProvider<StyleAppTheme>(
          create: (BuildContext context) => StyleAppTheme(),
        ),
        BlocProvider<MapsBloc>(
          create: (context) => MapsBloc(),
        ),
        BlocProvider<NavigationController>(
          create: (context) => NavigationController(),
        ),
        BlocProvider<RentalControllerBloc>(
          create: (context) => RentalControllerBloc(),
        ),
        BlocProvider<FilterCubit>(
          create: (BuildContext context) =>
              FilterCubit(Filter.values(
                  maxPrice: 600.0,
                  minPrice: 50,
                  maxDistance: 5.0,
                  minDistance: 0.0,
                  categoryList: const [])),
        ),
      ],
      child: BlocBuilder<StyleAppTheme, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Exploress KodishApp",
            navigatorKey: _navigatorKey,
            theme: ThemeData.dark().copyWith(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColorLight: Colors.teal,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.cyan,
              ),
            ),
            //supportedLocales: const <Locale>[Locale('fr')],
            //home: HomePage(),
            //initialRoute: RouteManager.kRoutes.keys.elementAt(1),
            routes: RouteManager.kRoutes,
            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      _navigator.pushNamedAndRemoveUntil<void>(
                        HomePage.routeName, (route) => false,
                      );
                      break;
                    default:
                      _navigator.pushNamedAndRemoveUntil<void>(
                        LoginPage.routeName, (route) => false,
                      );
                      break;
                  }
                },
                child: child,
              );
            },
            onGenerateRoute: (_) => OnGeneratePage.route(),
            onUnknownRoute: (_) => On404Page.route(),


          );
        },
      ),
    );
  }
}



