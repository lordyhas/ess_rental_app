import 'package:exploress_rental/logic/map_data/maps.dart';
import 'package:exploress_rental/src/myspace_page.dart';
import 'package:exploress_rental/src/preference_page/about_page.dart';
import 'package:exploress_rental/src/home_page.dart';
import 'package:exploress_rental/src/login_page.dart';
import 'package:exploress_rental/src/maps_test.dart';
import 'package:exploress_rental/src/add_rent_page/add_rent_page.dart';
import 'package:exploress_rental/src/home_page/place_info_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:exploress_rental/logic/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:exploress_rental/on_error_page.dart';

import 'package:exploress_rental/firebase_options.dart';

//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "exploressrental",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

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
  ]).then((value) => runApp(MyApp(authRepository: AuthenticationRepository())));
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
        create: (_) => AuthenticationBloc(
          authRepository: authRepository,
        ),
        child: EssRentApp(),
      ),
    );
  }
}

class EssRentApp extends StatelessWidget {
  EssRentApp({super.key});

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  //NavigatorState get _navigator => _navigatorKey.currentState!;

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
          create: (BuildContext context) => FilterCubit(
            Filter.values(
                maxPrice: 600.0,
                minPrice: 50,
                maxDistance: 5.0,
                minDistance: 0.0,
                categoryList: const []),
          ),
        ),
      ],
      child: BlocBuilder<StyleAppTheme, ThemeData>(
        builder: (context, theme) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: AppConstant.markName,
                theme: ThemeData.dark().copyWith(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  primaryColorLight: Colors.tealAccent.shade400,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.cyan.withOpacity(1),
                  ),
                ),
                //supportedLocales: const <Locale>[Locale('fr')],

                routerConfig: GoRouter(
                  navigatorKey: _rootNavigatorKey,
                  errorBuilder: (context, state) => OnErrorPage(
                    error: state.error,
                  ),
                  redirect: (context, state) {
                    return null;
                    if (authState.status != AuthenticationStatus.authenticated) {
                      return "/root/my_account/login";
                    } else {
                      return null;
                    }
                  },

                  initialLocation: LoginPage.routeName, //"${HomePage.routeName}",
                  //HomePage.routeName,
                  routes: [

                    ShellRoute(
                      navigatorKey: _shellNavigatorKey,
                      builder: (context, state, child) => HomePage(child: child),
                      routes: [
                        GoRoute(
                          name: HomePage.routeName,
                          path: HomePage.routeName,
                          redirect: (context, state){
                            if (authState.status != AuthenticationStatus.authenticated) {
                              return LoginPage.routeName;
                            } else {
                              return null;
                            }
                          },
                          builder: (context, state) => const NestedWebView(
                            child: HomeScreen(),
                          ),
                          routes: <RouteBase>[
                            GoRoute(
                              name: UserSpaceScreen.routeName,
                              path: 'user/myspace',
                              builder: (ctx, state) {
                                return const NestedWebView(
                                  child: UserSpaceScreen(),
                                );
                              },
                            ),
                            GoRoute(
                              parentNavigatorKey: _rootNavigatorKey,
                              name: AddRentPage.routeName,
                              path: "user/form",
                              builder: (context, state) => const AddRentPage(),
                            ),
                            GoRoute(
                              name: RentProductScreen.routeName,
                              path: "explore",
                              builder: (ctx, state) {
                                return const RentProductScreen();
                              },
                              routes: [
                                GoRoute(
                                  parentNavigatorKey: _rootNavigatorKey,
                                  name: PlaceInfoScreen.routeName,
                                  path: "places/single-place",
                                  builder: (context, state) => PlaceInfoScreen(
                                    placeData: state.extra as PlaceInfoData,
                                  ),
                                ),
                                GoRoute(
                                  parentNavigatorKey: _rootNavigatorKey,
                                  name: MapSample.routeName,
                                  path: "map",
                                  builder: (context, state) => MapSample(
                                    initialPosition: state.extra as LatLng?,
                                  ),
                                ),
                              ],
                            ),
                            GoRoute(
                                name: SettingScreen.routeName,
                                path: 'setting',
                                builder: (ctx, state) =>
                                    const SettingScreen(),
                                routes: [
                                  GoRoute(
                                    name: AboutPage.routeName,
                                    path: "about",
                                    builder: (ctx, state) => const AboutPage(),
                                  ),
                                ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      name: LoginPage.routeName,
                      path: LoginPage.routeName,
                      builder: (context, state) => const LoginPage(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/**

    MaterialApp(
    debugShowCheckedModeBanner: false,
    title: AppConstant.markName,
    navigatorKey: _navigatorKey,
    theme: ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColorLight: Colors.tealAccent.shade400,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan.withOpacity(1),
    ),
    ),
    //supportedLocales: const <Locale>[Locale('fr')],
    //home: HomePage(),
    initialRoute: HomePage.routeName, /*connect.status == AuthenticationStatus.authenticated
    ? HomePage.routeName
    : LoginPage.routeName,*/
    routes: RouteManager.kRoutes,
    /*builder: (context, child) {
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
    },*/
    //onGenerateRoute: (_) => OnGeneratePage.route(),
    //onUnknownRoute: (_) => On404Page.route(),


    );


 */
