

library data.model;

import 'package:google_maps_flutter/google_maps_flutter.dart';




part 'shop_data.dart';

class AddressData {
  final String avenue;
  final String? town;
  final String zone;
  final int number;
  final String commune;

  AddressData({
    required this.avenue,
    this.town,
    required this.zone,
    required this.number,
    required this.commune,
  });

  Map<String,dynamic> asMap() => {
    'avenue': avenue,
    'town': town,
    'zone': zone,
    'number': number,
    'commune': commune,
  };

  factory AddressData.fromMap(Map<String,dynamic> map) => AddressData(
    avenue: map['avenue'],
    zone: map['zone'],
    number:map['number'],
    commune: map['commune'],
    town: map['town'],

  );

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class Ratings {
  final id;
  final int score;
  final String message;
  final String userCode;
  final String shopCode;
  final DateTime timeMessage;
  final DateTime? timeShopMessage;
  final String? shopMessage;

  const Ratings({
    this.id,
    required this.score,
    required this.message,
    required this.userCode,
    required this.shopCode,
    required this.timeMessage,
    this.timeShopMessage,
    this.shopMessage});


}

class ImageLinkStorage {
  final id;
  final String? primary;
  final String? left;
  final String? right;
  final String? top;
  final String? bottom;

  const ImageLinkStorage({
    this.id,
    this.primary,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  List<String?> toList() => [primary, left, right, top, bottom];
}



extension on DateTime {
  static DateTime datePlan(
      {required int day, required int hour, required int minute}) {
    var d = DateTime.now();
    return DateTime(
      d.year,
      d.month,
      day,
      hour,
      minute,
    );
  }
}