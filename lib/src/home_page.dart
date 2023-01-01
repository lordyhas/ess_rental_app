library home_page;

import 'dart:math';

import 'package:exploress_rental/logic/map_data/maps.dart';
import 'package:exploress_rental/logic/values.dart';
import 'package:exploress_rental/src/login_page.dart';
import 'package:exploress_rental/src/preference_page/edit_profile_page.dart';
import 'package:exploress_rental/src/add_rent_page/add_rent_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:latlong2/latlong.dart' as dist;
import 'package:exploress_rental/data_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:exploress_rental/src/maps_test.dart';
import 'package:exploress_rental/src/preference_page/about_page.dart';
import 'package:exploress_rental/src/home_page/rental_product/rental_product.dart';
import 'package:exploress_rental/src/home_page/rental_product/filters_screen.dart';
import 'package:exploress_rental/src/home_page/rental_product/model/rental_model.dart';
import 'package:exploress_rental/src/home_page/place_info_screen.dart';
import 'package:exploress_rental/src/myspace_page.dart';

part 'home_page/rental_screen.dart';

part 'setting_profile_screen.dart';

part 'home_page/home_screen.dart';

part 'home_page/nested_web_view.dart';

part 'home_page/app_bar_view.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  final Widget child;

  const HomePage({
    this.child = const SizedBox(),
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void closeDrawer() => _scaffoldKey.currentState?.closeDrawer();

  List<DrawerItem> get items => <DrawerItem>[
        DrawerItem(
            navigationScreen: NavigationScreen.home,
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: const Text('Acceuil'),
            onPressed: () {
              BlocProvider.of<NavigationController>(context)
                  .setState(NavigationScreen.home);
              GoRouter.of(context).goNamed(HomePage.routeName);
              closeDrawer();
              //setState(() {});
            }),
        DrawerItem(
            navigationScreen: NavigationScreen.explorer,
            icon: const Icon(Icons.view_carousel_outlined),
            selectedIcon: const Icon(Icons.view_carousel),
            label: const Text('Explorer'),
            onPressed: () {
              GoRouter.of(context).goNamed(RentProductScreen.routeName);
              closeDrawer();
              //_scaffoldKey.currentState?.closeDrawer();
              //setState(() {});
            }),
        DrawerItem(
            navigationScreen: NavigationScreen.setting,
            icon: const Icon(Icons.settings),
            selectedIcon: const Icon(Icons.settings),
            label: const Text('Préférences'),
            onPressed: () {
              //_scaffoldKey.currentState?.closeDrawer();
              GoRouter.of(context).goNamed(SettingScreen.routeName);

              closeDrawer();

              //setState(() {});
            }),
      ];

  FloatingActionButton get floatingActionButton => FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (kIsWeb) {
            launchMapOnWeb();
          } else {
            Navigator.push(context, MapSample.route());
          }
        },
        child: const Icon(CupertinoIcons.map),
      );

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      print("==== MediaQuery.of(context).size.width : $screenWidth");
    }
    GoRouter.of(context).addListener(() {
      if (GoRouter.of(context).location == HomePage.routeName) {
        BlocProvider.of<NavigationController>(context)
            .setState(NavigationScreen.home);
      }
    });

    return Material(
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        child: Row(
          children: <Widget>[
            ///  NavigationRail ++++++++++++++++++++++
            if (screenWidth > kPhoneDimens && kIsWeb)
              BlocBuilder<NavigationController, NavigationScreen>(
                builder: (context, state) {
                  int index = state.index <= 2 ? state.index : 2;
                  return NavigationRail(
                    selectedIndex: index,
                    groupAlignment: 1.0,
                    onDestinationSelected: (int index) {
                      items[index].onPressed!();
                    },
                    labelType: (screenWidth < 800)
                        ? NavigationRailLabelType.none
                        : NavigationRailLabelType.all,
                    leading: floatingActionButton,
                    destinations: items
                        .map((item) => NavigationRailDestination(
                              icon: item.icon,
                              selectedIcon: item.selectedIcon,
                              label: item.label,
                            ))
                        .toList(),
                  );
                },
              ),

            //const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Scaffold(
                key: _scaffoldKey,
                //floatingActionButton: responsive.isPhone ? floatingActionButton : null,

                appBar: AppBar(
                  elevation: 0.0,
                  //centerTitle: kIsWeb,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: responsive.isPhone ? null : Container(),
                  title: Row(
                    children: [
                      const Text(
                        'KodishApp',
                        style: TextStyle(
                          //color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      BooleanBuilder(
                        condition: () =>
                            screenWidth > (kPhoneDimens - 40) && kIsWeb,
                        ifTrue: Row(
                          children: [
                            TextButton(
                              child: const Text("My Space"),
                              onPressed: () => GoRouter.of(context)
                                  .goNamed(UserSpace.routeName),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            TextButton(
                              child: const Text("About"),
                              onPressed: () => GoRouter.of(context)
                                  .goNamed(AboutPage.routeName),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Help"),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("FAQ"),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                          ],
                        ),
                        ifFalse: const SizedBox.shrink(),
                      ),
                    ],
                  ),

                  actions: [
                    /*IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.notifications))*/

                    PopupMenuButton(
                      //enabled: false,
                      tooltip: "",
                      icon: const Icon(Icons.notifications),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        const PopupMenuItem<int>(
                          value: 1,
                          child: ListTile(
                            title: Text('Heritier M.'),
                            subtitle: Text(
                                "Bonjour, Je cherche une maison 3 pièce ?"),
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 2,
                          child: ListTile(
                            title: Text('Mark'),
                            subtitle:
                                Text("Salut, je peux avoir votre adresse ?"),
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 3,
                          child: ListTile(
                            title: Text('Sami Konda'),
                            subtitle: Text("J'ai besoin d'aide, svp"),
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 3,
                          child: ListTile(
                            title: Text('Olga Wivine'),
                            subtitle: Text("Merci beaucoup."),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                drawer: Drawer(
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Column(
                          children: [
                            const Spacer(),
                            Image.asset(
                              "assets/icon_app.png",
                              width: 100,
                            ),
                            const Spacer(),
                            const Text(
                              AppConstant.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      BlocBuilder<NavigationController, NavigationScreen>(
                        builder: (context, state) {
                          return Column(
                            children: items
                                .map((item) => SizedBox(
                                      child: ListTile(
                                        key: item.key,
                                        leading: item.icon,
                                        // ? : item.selectedIcon
                                        title: item.label,
                                        onTap: item.onPressed,
                                        selected:
                                            state == item.navigationScreen,
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                      const Spacer(),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          BlocProvider.of<NavigationController>(context)
                              .setState(NavigationScreen.myspace);
                          closeDrawer();
                        },
                        horizontalTitleGap: 32.0,
                        style: ListTileStyle.drawer,
                        leading: Ink(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColorLight),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.space_dashboard,
                            ),
                          ),
                        ),
                        title: const Text(
                          "MySpace",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        horizontalTitleGap: 32.0,
                        style: ListTileStyle.drawer,
                        leading: Ink(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.more_horiz),
                          ),
                        ),
                        title: const Text(
                          "Plus",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final NavigationScreen navigationScreen;
  final Widget icon;
  final Widget selectedIcon;
  final Widget label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Key? key;

  const DrawerItem({
    required this.navigationScreen,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.onPressed,
    this.padding,
    this.key,
  });
}

/*
 Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(

        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.1,
            height: MediaQuery.of(context).size.height, 
            child: Container(
              color: Colors.green,
              child: Column(
                children: [
                  Ink
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(),
            ),
          ),
        ],
      ),
    );
*/
