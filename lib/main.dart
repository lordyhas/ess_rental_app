import 'package:exploress_location/logic/map_data/maps.dart';
import 'package:exploress_location/src/home_page.dart';
import 'package:exploress_location/src/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:exploress_location/logic/values.dart';
import 'package:permission_handler/permission_handler.dart';

part 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const EssApp()));
}

class EssApp extends StatelessWidget {
  const EssApp({super.key});

  void _checkSomePermissions() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      //Permission.camera,
      //Permission.locationAlways,
    ].request();
    debugPrint("storage Permission :${statuses[Permission.storage]}");
  }

  @override
  Widget build(BuildContext context) {
    _checkSomePermissions();

    return MultiBlocProvider(
      providers: [
        BlocProvider<StyleAppTheme>(
          create: (BuildContext context) => StyleAppTheme(),
        ),
        BlocProvider<MapsBloc>(
          create: (context) => MapsBloc(),
        ),
        BlocProvider<FilterCubit>(
          create: (BuildContext context) => FilterCubit(Filter.values(
              maxPrice: 600.0,
              minPrice: 50,
              maxDistance: 5.0,
              minDistance: 0.0,
              categoryList: [])),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: ShopPage.routeName, //RouteManager.kRoutes.keys.first,
        routes: RouteManager.kRoutes,
      ),
    );
  }
}
