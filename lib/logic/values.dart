library values;

import 'package:exploress_location/logic/values/dimens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

//import 'dart:io' show Platform;

export 'controller/my_bloc_controller.dart';
export 'values/styles.dart';
export 'values/dimens.dart';
//export 'values/colors.dart';


part 'category.dart';
part 'distance.dart';


Future<T?>? goto<T>(
    BuildContext context, {
      required Widget page,
      required String routeName,
      dynamic args,
    }) {

  return Navigator.pushNamed<T>(
    context,
    routeName,
    arguments: args,
  );
  if (!kIsWeb) {
    //Navigator.of(context).push(route);
    return Navigator.push(
        context,
        MaterialPageRoute<T>(
            builder: (_) => page,
            settings: RouteSettings(
              arguments: args,
            )));
    //Get.to(() => page);
  } else {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: args,
    );
    //Get.toNamed(routeName);
  }
}

class Go {
  static Future<T?>? to<T>(
      BuildContext context, {
        required Widget page,
        required String routeName,
        dynamic args,
      }) {
    return goto<T>(context,
        page: page, routeName: routeName, args: args);
    /*if(!kIsWeb){
     return Get.to(page);
      //Get.to(() => page);
    } else{
      return Get.toNamed(routeName);
    }*/
  }
}

class Responsive {
  final BuildContext context;
  const Responsive._(this.context);
  static Responsive of(BuildContext context) => Responsive._(context);
  Size get size => MediaQuery.of(context).size;
  bool get isPhone => size.width <= kPhoneDimens || !kIsWeb;// || Platform.isAndroid;
  bool get isWeb => size.width > kPhoneDimens || kIsWeb;
  bool get isOnlyWeb => kIsWeb;
  bool get isWindows => size.width > kPhoneDimens;// || Platform.isWindows;
  bool get isMacOS => size.width > kPhoneDimens;// || Platform.isMacOS;
}

Future<void> launchMapOnWeb({maps.LatLng? latLng}) async {
  double lat = latLng?.latitude ?? -10.6284708;
  double lng = latLng?.latitude ?? 20.487585;
  String latlng = "$lat,$lng";
  if(!kIsWeb) return;
  final Uri url = Uri.parse("https://maps.google.com/?q=$latlng");
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

const firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyCo3HsagcBMquvmH7GLpvpIQRtAdY-zYLg",
    authDomain: "exploress-aa508.firebaseapp.com",
    databaseURL: "https://exploress-aa508.firebaseio.com",
    projectId: "exploress-aa508",
    storageBucket: "exploress-aa508.appspot.com",
    messagingSenderId: "1021422010903",
    appId: "1:1021422010903:web:8a24abe50fadfcfca99252",
    measurementId: "G-V0Y96W3WTP"
);


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}


