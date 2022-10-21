library shop_page;
import 'dart:math';
import 'dart:ui';

import 'package:exploress_location/logic/values.dart';
import 'package:exploress_location/src/shop/shop_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../data_test.dart';
import '../logic/map_data/maps.dart';
import 'maps_test.dart';
import 'shop/calendar_popup_view.dart';
import 'shop/shop_list_view.dart';
import 'shop/model/shop_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'shop/filters_screen.dart';
//i/mport 'profiles/maps_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:latlong2/latlong.dart' as dist;

part 'shop/shop_home_screen.dart';

class ShopPage extends StatefulWidget {
  static const routeName = '/home/rent';

  const ShopPage({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ShopPage());
  }

  @override
  State createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarColor: Colors.transparent,
      //statusBarIconBrightness: Theme.of(context).brightness,
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    var position = BlocProvider.of<MapsBloc>(context).state.maps;

    List<ShopItemData> shopItemList = DataTest.shops.map((shop) =>
        ShopItemData(
          imagePath: shop.imagePath!,
          titleTxt: shop.shopName,
          subTxt: 'Lubumbashi, CD',
          distance: distance(
              fromLatLng: position.currentLatLngFromDistance,
              toLatLng: dist.LatLng(
                  shop.location!.latitude,
                  shop.location!.longitude
              )
          ),
          reviews: 80,
          rating: shop.rating/shop.rater,
          perNight: 180,
          shop: shop,
        ),).toList();
    //shopItemList.addAll(ShopItemData.sampleList);
    return ShopHomeScreen(shopList: shopItemList);
  }

}



/*Widget getTimeDateUI() {

    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1 Room - 2 Adults',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

