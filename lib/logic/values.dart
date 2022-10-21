import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'controller/filter_bloc/filter_cubit.dart';
export 'values/styles.dart';
export 'distance.dart';





Future<T?>? goto<T>(
    BuildContext context, {
      required Widget page,
      required String routeName,
      dynamic args,
    }) {
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