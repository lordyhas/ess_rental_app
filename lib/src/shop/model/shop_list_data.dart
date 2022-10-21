


import 'package:exploress_location/logic/model/data_model.dart';

class ShopItemData {
  ShopItemData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.distance = 1.8,
    this.reviews = 80,
    this.rating = 3,
    this.perNight = 0,
    this.shop,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double distance;
  double rating;
  int reviews;
  int perNight;
  ShopData? shop;

  /*static List<ShopItemData> sampleList = <ShopItemData>[

    ShopItemData(
      imagePath: 'assets/img/shop_image/shop (3).jpeg',
      titleTxt: 'Boutique Grand Boss',
      subTxt: 'Lubumbashi, CD',
      distance: 2.0,
      reviews: 820,
      rating: 2,
      perNight: 180,
    ),
    ShopItemData(
      imagePath: 'assets/img/shop_image/shop (4).jpeg',
      titleTxt: 'Queen Shop',
      subTxt: 'Lubumbashi, CD',
      distance: 4.0,
      reviews: 74,
      rating: 3,
      perNight: 200,
    ),

  ];*/
}
