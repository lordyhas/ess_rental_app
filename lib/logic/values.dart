library values;

import 'package:achievement_view/achievement_view.dart';
import 'package:exploress_rental/logic/values.dart';
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
export 'utils.dart';
export 'extension.dart';
export 'package:utils_component/utils_component.dart' hide Responsive, Go;
export 'package:go_router/go_router.dart';

//export "package:exploress_repository/exploress_bloc.dart" hide AppBlocObserver;
//export 'values/colors.dart';

part 'category.dart';

part 'distance.dart';

class Go {
  static void to(BuildContext context, {
    required String routeName,
    @Deprecated("not use no more") Widget? page,
    String? path,
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    dynamic args,
  }) {
    return GoRouter.of(context).goNamed(
        routeName,
        params: params,
        queryParams: queryParams,
        extra: args
    );
  }

  static GoRouter of(BuildContext context) => GoRouter.of(context);

}

extension XGO on GoRouter{
  void to({
    required String routeName,
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,}) => goNamed(
      routeName,
      params: params,
      queryParams: queryParams,
      extra: extra);
}

class Responsive {
  final BuildContext context;

  const Responsive._(this.context);

  static Responsive of(BuildContext context) => Responsive._(context);

  Size get size =>
      MediaQuery
          .of(context)
          .size;

  bool get isPhone =>
      size.width <= kPhoneDimens || !kIsWeb; // || Platform.isAndroid;
  bool get isWeb => size.width > kPhoneDimens || kIsWeb;

  bool get isOnlyWeb => kIsWeb;

  bool get isWindows => size.width > kPhoneDimens; // || Platform.isWindows;
  bool get isMacOS => size.width > kPhoneDimens; // || Platform.isMacOS;
}

Future<void> launchMapOnWeb({maps.LatLng? latLng}) async {
  double lat = latLng?.latitude ?? -10.6284708;
  double lng = latLng?.latitude ?? 20.487585;
  String latlng = "$lat,$lng";
  if (!kIsWeb) return;
  final Uri url = Uri.parse("https://maps.google.com/?q=$latlng");
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context,
      Widget child,
      AxisDirection axisDirection,) {
    return child;
  }
}

void showToastFavorite({required BuildContext context, String? message}) =>
    AchievementView(
      context,
      title: "Added to favorite",
      subTitle: message ?? "Place added to your favorite list",
      isCircle: true,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.favorite),
      color: Colors.teal.shade800,

      //onTab: _onTabAchievement,
      //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      //borderRadius: 5.0,
      //color: Colors.blueGrey,
      //textStyleTitle: TextStyle(),
      //textStyleSubTitle: TextStyle(),
      //alignment: Alignment.topCenter,
    ).show();
