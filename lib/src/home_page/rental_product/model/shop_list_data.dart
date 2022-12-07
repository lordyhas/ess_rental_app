part of rental.model;


class RentItemData {
  RentItemData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.distance = 1.8,
    this.reviews = 80,
    this.rating = 3,
    this.perNight = 0,
    this.rent,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double distance;
  double rating;
  int reviews;
  int perNight;
  dynamic rent;

}
