part of 'main.dart';

class RouteManager {
  /*static void to(BuildContext context, {
    required Widget page,
    required String routeName,
    dynamic args,}){
    return goto(context, page: page, routeName: routeName, args: args);
  }*/

  //static const routeName = '/home/explore';
  //static const routeName = "home/settings";
  static final kRoutes = <String, WidgetBuilder>{
    "/"                 : (context) => const HomePage(),
    "/home/explore"     : (context) => const HomePage(),
    "/home/settings"     : (context) => const HomePage(),
    HomePage.routeName  : (context) => const HomePage(),
    LoginPage.routeName : (context) => const LoginPage(),
    MapSample.routeName : (context) => const MapSample(),
    AddRentPage.routeName  : (context) => const AddRentPage(),
    AboutPage.routeName  : (context) => const AboutPage(),
    PlaceInfoScreen.routeName  : (context) => const PlaceInfoScreen(),
    MySpacePage.routeName  : (context) => const MySpacePage(),
    //ProfilePage.routeName  : (context) => const ProfilePage(),
  };
}
