
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
//import 'package:latlong2/latlong.dart' as dist;

import 'package:exploress_rental/logic/model/data_model.dart';


class DataTest {
  static List<ShopData> shops = [
    ShopData(
      shopName: "Espace de travail",
      shopCode: "prole123",
      imagePath: "assets/local/loc_bureau_1.jpg",
      email: 'travail@exploress.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      location: const maps.LatLng(-11.6284708, 27.487585),
    ),
    ShopData(
      shopName: "Local avec 2 bureau",
      shopCode: "prostyle123",
      imagePath: "assets/local/loc_bureau_2.jpg",
      email: 'prole243@exploress.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      location: const maps.LatLng(-11.6284708, 27.487585),
    ),
    ShopData(
      shopName: "Entrepot",
      shopCode: "galaxymobile1234",
      imagePath: "assets/local/loc_lib_2.png",
      email: 'galaxymobi@exploress.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: const maps.LatLng(-11.627637, 27.475301),
    ),
    ShopData(
      shopCode: 'BoutiqueGrandBoss1234',
      imagePath: 'assets/local/loc_reunion_1.png',
      shopName: 'Salle de reunion',
      email: 'useto@exploress.com',
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
      imagePath: 'assets/local/loc_restau_1.jpg',
      shopName: 'Restaurant à louer',
      email: 'momo@exploress.com',

      //subTxt: 'Lubumbashi, CD',
      rating: (3 + 3 + 4 + 5 + 2+5+5),
      rater: 7,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: const maps.LatLng(-11.628488, 27.483457),
    ),

    ShopData(
      shopCode: 'VIPQS1234',
      imagePath: 'assets/local/loc_reunion_2.jpg',
      shopName: 'Salle de reunion (VIP)',
      email: 'jojo-vip@exploress.com',

      //subTxt: 'Lubumbashi, CD',
      rating: (3 + 3 + 4 + 5 + 2+5+5),
      rater: 7,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: const maps.LatLng(-11.628488, 27.483457),
    ),

    ShopData(
      shopName: "Magasin",
      shopCode: "galaile1234",
      imagePath: "assets/local/loc_lib_1.jpg",
      email: 'magas@exploress.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
      location: const maps.LatLng(-11.627637, 27.475301),
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
