part of 'main.dart';

class RouteManager {
  /*static void to(BuildContext context, {
    required Widget page,
    required String routeName,
    dynamic args,}){
    return goto(context, page: page, routeName: routeName, args: args);
  }*/
  static final kRoutes = <String, WidgetBuilder>{

    HomePage.routeName: (context) => const HomePage(),
    ShopPage.routeName: (context) => const ShopPage(),
    //LoginPage.routeName: (context) => const LoginPage(),
    };

}


