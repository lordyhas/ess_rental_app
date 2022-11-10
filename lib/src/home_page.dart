library home_page;

import 'dart:math';

import 'package:exploress_location/logic/map_data/maps.dart';
import 'package:exploress_location/logic/values.dart';
import 'package:exploress_location/src/rental_page.dart';
import 'package:exploress_location/src/shop/calendar_popup_view.dart';
import 'package:exploress_location/src/shop/filters_screen.dart';
import 'package:exploress_location/src/shop/model/shop_list_data.dart';
import 'package:exploress_location/src/shop/shop_info_screen.dart';
import 'package:exploress_location/src/shop/shop_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:latlong2/latlong.dart' as dist;

import 'package:exploress_location/data_test.dart';
import 'package:utils_component/utils_component.dart' hide Go;

import 'package:package_info_plus/package_info_plus.dart';

import 'package:exploress_location/src/maps_test.dart';

part 'shop/shop_home_screen.dart';
part 'settings_page.dart';
part 'home_page/home_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  //static const routeName = '/home';


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 1;



  List<DrawerItem> get items => <DrawerItem>[
        DrawerItem(navigationScreen: NavigationScreenState.home,
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: const Text('Acceuil'),
            onPressed: () {
              BlocProvider.of<NavigationControllerCubit>(context)
                  .changeScreen(NavigationScreenState.home);
              _scaffoldKey.currentState?.closeDrawer();
              setState(() {});
            }),
        DrawerItem(
            navigationScreen: NavigationScreenState.explorer,
            icon: const Icon(Icons.view_carousel_outlined),
            selectedIcon: const Icon(Icons.view_carousel),
            label: const Text('Explorer'),
            onPressed: () {
              BlocProvider.of<NavigationControllerCubit>(context)
                  .changeScreen(NavigationScreenState.explorer);
              _scaffoldKey.currentState?.closeDrawer();
              setState(() {});
            }),
        DrawerItem(
            navigationScreen: NavigationScreenState.setting,
            icon: const Icon(Icons.settings),
            selectedIcon: const Icon(Icons.settings),
            label: const Text('Préférences'),
            onPressed: () {
              BlocProvider.of<NavigationControllerCubit>(context)
                  .changeScreen(NavigationScreenState.setting);
              _scaffoldKey.currentState?.closeDrawer();

              setState(() {});

            }),
      ];

  FloatingActionButton get floatingActionButton => FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (kIsWeb) {
            launchMapOnWeb();
          } else {
            Navigator.push(
                context,
                MapSample.route(
                    //initialPosition: shopList[index].shop?.location,
                    ));
          }
        },
        child: const Icon(CupertinoIcons.map),
      );

  void _onMenuTap() {
    _scaffoldKey.currentState?.openDrawer();
    //Scaffold.of(context).openDrawer();
    if (kDebugMode) {
      print('======== Scaffold.of(context).openDrawer();\n'
          '======== Scaffold.hasDrawer(context): '
          '${Scaffold.hasDrawer(context)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      print("==== MediaQuery.of(context).size.width : $screenWidth");
    }

    if (!kIsWeb) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ));
    }

    return Row(
      children: <Widget>[
        if (screenWidth > kPhoneDimens && kIsWeb)
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: 1.0,
            onDestinationSelected: (int index) {
              items[index].onPressed!();
              setState(() {
                _selectedIndex = index;
              });

            },
            labelType: (screenWidth < 800)
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            leading: floatingActionButton,
            destinations: <NavigationRailDestination>[
              ...items
                  .map(
                    (item) => NavigationRailDestination(
                  icon: item.icon,
                  selectedIcon: item.selectedIcon,
                  label: item.label,
                ),
              )
                  .toList()
            ],
          ),
        ///const VerticalDivider(thickness: 1, width: 1),
        // This is the main content.
        Expanded(
          child: Scaffold(
            key: _scaffoldKey,
            floatingActionButton: responsive.isPhone ? floatingActionButton : null,

            appBar: AppBar(
              elevation: 0.0,
              centerTitle: kIsWeb,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: responsive.isPhone ? null : Container(),
              title: Container(
                child: const Text(
                  'SpaceForRent',
                  style: TextStyle(
                    //color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
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
                          "SpaceForRent",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  ...items
                      .map((item) => SizedBox(
                    child: ListTile(
                      key: item.key,
                      leading: item.icon, // ? : item.selectedIcon
                      title: item.label,
                      onTap: item.onPressed,
                      selected: BlocProvider
                          .of<NavigationControllerCubit>(context)
                          .state == item.navigationScreen,
                    ),
                  ))
                      .toList(),
                  const Spacer(),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    horizontalTitleGap: 32.0,
                    style: ListTileStyle.drawer,
                    leading: Ink(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.secondary),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.person,),
                      ),
                    ),
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: (){},
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
            body: BlocBuilder<NavigationControllerCubit,
                NavigationScreenState>(
              //bloc: NavigationControllerCubit(),
              builder: (context, state) {
                switch(state){
                  case NavigationScreenState.home:
                    return const HomeScreen();
                  case NavigationScreenState.explorer:
                    return ShopHomeScreen(

                        shopList: DataTest.shops
                            .map(
                              (shop) => ShopItemData(
                            imagePath: shop.imagePath!,
                            titleTxt: shop.shopName,
                            subTxt: 'Lubumbashi, CD',
                            distance: distance(
                                fromLatLng:
                                BlocProvider.of<MapsBloc>(context)
                                    .state
                                    .maps
                                    .currentLatLngFromDistance,
                                toLatLng: dist.LatLng(
                                    shop.location!.latitude,
                                    shop.location!.longitude)) /
                                1000,
                            reviews: 80,
                            rating: shop.rating / shop.rater,
                            perNight: 180,
                            shop: shop,
                          ),
                        )
                            .toList());
                //break;
                  case NavigationScreenState.setting:
                    return SettingPage();
                //break;
                }

                //if(state is NavigationScreenHome)


              },
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarView extends StatelessWidget {
  final void Function()? onMenuTap;

  const AppBarView({this.onMenuTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AppBar appBar = AppBar();
    return PreferredSize(
      preferredSize: appBar.preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 8, right: 8),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: appBar.preferredSize.height + 40,
                height: appBar.preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: BooleanBuilder(
                      check: Responsive.of(context).isPhone,
                      ifFalse: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: null, //,
                      ),
                      ifTrue: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: onMenuTap,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'SpaceForRent',
                    style: TextStyle(
                      //color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                width: appBar.preferredSize.height + 50,
                height: appBar.preferredSize.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /*Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.favorite_border,
                                color: Theme.of(context).primaryColorDark,
                              )

                          ),
                        ),
                      ),
                    ),*/
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: () {
                          Navigator.push(context, MapSample.route());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Responsive.of(context).isPhone
                              ? null
                              : const Icon(
                                  FontAwesomeIcons.locationDot,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem {
  final NavigationScreenState navigationScreen;
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
