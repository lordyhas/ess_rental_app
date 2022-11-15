part of rental.stuff;

class SpaceListView extends StatelessWidget {
  //final heroTag;
  const SpaceListView({
    required this.spaces, //this.heroTag,
    //required this.animationController,
    //required this.animation,
    required this.onShopClick,
    required this.onLikeClick,
    required this.onHueClick,
    super.key,
  });

  final Function(int index) onShopClick;
  final Function(int index) onHueClick;
  final Function(int index) onLikeClick;
  final List<RentItemData> spaces;

  //final AnimationController animationController;
  //final Animation<double> animation;

  //bool favorite = false;

  @override
  Widget build(BuildContext context) {
    double responsiveSize() {
      double screenWidth = MediaQuery.of(context).size.width;
      //if(screenWidth > 1280) return 500;
      if (screenWidth > 1280 && screenWidth < 1400) {
        return 500;
      } else if (screenWidth >= 1400 && screenWidth < 1650) {
        return 600;
      } else if (screenWidth >= 1650) {
        return 720;
      } else if (screenWidth < 1280 && screenWidth >= 1120) {
        return 460;
      } else if (screenWidth < 1120) {
        return 700;
      }

      return 700;
    }

    final _textStyle = TextStyle(
        fontSize: 14,
        color: (Theme.of(context).brightness != Brightness.dark)
            ? Colors.grey.shade600
            : Colors.grey.shade400);

    return Material(
      color: Colors.transparent,
      child: Wrap(
          spacing: 8.0,
          alignment: WrapAlignment.center,
          children: List.generate(
            spaces.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () => onShopClick(index),
                onLongPress: () {},
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: responsiveSize(),
                  ),
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
                                spaces[index].imagePath,
                                fit: BoxFit.cover,
                                gaplessPlayback: true,
                              ),
                            ),

                            /// Bottom bar of Card
                            Container(
                              color: Colors.grey.shade800,
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
                                            spaces[index].titleTxt,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
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
                                                spaces[index].subTxt,
                                                style: _textStyle,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.locationDot,
                                                size: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' à ${spaces[index].distance.toStringAsFixed(1)} km du centre ville',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: _textStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              StarRating(
                                                allowHalfRating: true,
                                                starCount: 5,
                                                rating: spaces[index].rating,
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
                                                ' ${spaces[index].reviews} Reviews',
                                                style: _textStyle,
                                              ),
                                            ],
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
                                          onPressed: () => onHueClick(index),
                                          icon: Icon(
                                            FontAwesomeIcons.locationDot,
                                            size: 32,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
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
                              onLikeClick(index);
                              //this.favorite = !this.favorite;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: Theme.of(context).colorScheme.secondary,
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
          )),
    );
  }
}
