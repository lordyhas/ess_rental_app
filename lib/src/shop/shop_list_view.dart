import 'package:flutter/cupertino.dart';

import 'package:exploress_location/widgets/StarRating.dart';
import 'shop_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:exploress_location/src/shop/model/shop_list_data.dart';

class ShopListView extends StatelessWidget {
  //final heroTag;
  const ShopListView(
      {Key? key,
      this.shopItem, //this.heroTag,
      //required this.animationController,
      //required this.animation,
      required this.onShopClick,
      required this.onLikeClick,
        required this.onHueClick,
      })
      : super(key: key);

  final Function() onShopClick;
  final Function() onHueClick;
  final Function() onLikeClick;
  final ShopItemData? shopItem;
  //final AnimationController animationController;
  //final Animation<double> animation;

  //bool favorite = false;

  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(fontSize: 14,
        color: (Theme.of(context).brightness != Brightness.dark)
            ? Colors.grey.shade600
            : Colors.grey.shade400
    );

    final __bottomBarCardColor = (Theme.of(context).brightness != Brightness.dark)
        ? Colors.white70
        : Colors.grey.shade800;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: 8, bottom: 16),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: onShopClick,
          onLongPress: (){},
          child: Container(
            /*decoration: BoxDecoration(
              //borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              //border: Border.all(color: Colors.black)
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  offset: const Offset(4, 4),
                  blurRadius: 16,
                ),
              ],
            ),*/
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 2,
                        child: Image.asset(
                          shopItem!.imagePath,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                      ),
                      /// Bottom bar of Card
                      Container(
                        color:  Colors.grey.shade800,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      shopItem!.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          shopItem!.subTxt,
                                          style: _textStyle,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        Expanded(
                                          child: Text(
                                            ' à ${shopItem!.distance.toStringAsFixed(1)} km de vous',
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: _textStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      //padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: <Widget>[
                                          StarRating(
                                            allowHalfRating: true,
                                            starCount: 5,
                                            rating: shopItem!.rating,
                                            size: 20,

                                          ),
                                          //for (var i = 0; i < 3; ++i)
                                          //Icon(Icons.star, size: 15, color: Colors.amber,),
                                          //Icon(Icons.star_half, size: 15, color: Colors.amber,),
                                          //Icon(Icons.star_border, size: 15, color: Colors.amber,),

                                          /*Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                                                  height: 10,
                                                  width: 10,
                                                  child: Icon(Icons.star, size: 15,),
                                                ),*/
                                          Text(
                                            ' ${shopItem!.reviews} Reviews',
                                            style: _textStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  right: 16, top: 4),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                      onPressed: onHueClick,
                                      icon: Icon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        size: 32,
                                        color: Theme.of(context).accentColor,
                                      ),
                                  ),

                                  /*Text(
                                    '\$${shopItem!.perNight}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),*/
                                  Text(
                                    'explore',
                                    style: _textStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /// Like Position Clicker Widget
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        onLikeClick();
                        //this.favorite = !this.favorite;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
