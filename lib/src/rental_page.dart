library rent_page;

import 'dart:async';
import 'dart:io';


import 'package:exploress_location/logic/values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:utils_component/utils_component.dart' hide Go;

part 'rent_page/rent_screen.dart';
part 'rent_page/rent_upload_image.dart';

class RentPage extends StatelessWidget {
  static const routeName = "/home/rent?id=sfr";
  const RentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Faire louer"),),
      body: const RentScreen(),
    );
  }
}
