
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:latlong2/latlong.dart' as dist;

import 'package:exploress_location/logic/model/data_model.dart';

class DataTest {
  static List<ShopData> shops = [
    ShopData(
      shopName: "ProStyle 243",
      shopCode: "prostyle123",
      imagePath: "assets/shop_image/shop (1).jpeg",
      email: 'prostyle243@exploress.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      location: const maps.LatLng(-11.6284708, 27.487585),
    ),
    ShopData(
      shopName: "Galaxy Mobile",
      shopCode: "galaxymobile1234",
      imagePath: "assets/shop_image/shop (6).jpeg",
      email: 'galaxymobile@exploress.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: const maps.LatLng(-11.627637, 27.475301),
    ),
    ShopData(
      shopCode: 'BoutiqueGrandBoss1234',
      imagePath: 'assets/shop_image/shop (3).jpeg',
      shopName: 'Boutique Grand Boss',
      //subTxt: 'Lubumbashi, CD',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: const maps.LatLng(-11.654236, 27.482564),
    ),
    ShopData(
      shopCode: 'QS1234',
      imagePath: 'assets/shop_image/shop (4).jpeg',
      shopName: 'Queen Shop',
      //subTxt: 'Lubumbashi, CD',
      rating: (3 + 3 + 4 + 5 + 2+5+5),
      rater: 7,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: maps.LatLng(-11.628488, 27.483457),
    ),
  ];

  /*static void addProduct() {
    FirebaseManager firebaseManager = FirebaseManager();
    ProductData productData = ProductData(
      productName: "Xiaomi 11 Ultra 5G",
      shopCode: shops.first.shopCode,
      productCode:  DateTime.now().microsecondsSinceEpoch.toString(),
      price: 1200,
      isTendency: true,
      stockNumber: 10,
      //category: ,
      imagePath: '',
      about: "Xiaomi 11 Ultra, 5G"

    );

    ///firebaseManager.addProduct(productData: productData);
  }*/
}
