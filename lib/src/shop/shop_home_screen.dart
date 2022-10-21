
part of shop_page;

class ShopHomeScreen extends StatelessWidget {
  final List<ShopItemData> shopList;
  const ShopHomeScreen({required this.shopList, super.key, });

  @override
  Widget build(BuildContext context) {
    Brightness _currentBrightness = Theme.of(context).brightness;
    
    var images = [
      "assets/img/pub_headset.jpeg",
      "assets/img/pub_sofa.jpeg",
    ];

    /*Future<bool> _willPopDialog(){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Theme.of(context).brightness,
            systemNavigationBarColor: Theme.of(context).primaryColor,
          )
      );

      return Future.value(true);
      //return Future.value(true);
    }*/
    void onMapClickOpenPage(int index){
      Navigator.push(context, MapSample.route(
        initialPosition: shopList[index].shop?.location,
      ));
    }
    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      body: Column(
        children: <Widget>[
          getAppBarUI(context),
          Expanded(
            child: NestedScrollView(
              //controller: _scrollController,
                headerSliverBuilder: (context,innerBoxIsScrolled) {
                  return <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  height: 150,
                                  child: Image.asset(images.elementAt(Random().nextInt(2)),
                                    //colorBlendMode: BlendMode,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    gaplessPlayback: true,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150, //MediaQuery.of(context).size.width,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                Column(
                                  children: <Widget>[
                                    getSearchBarUI(context),
                                    Container(
                                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                                        child: const Text("Find a shop near to you, Exploress",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70
                                          ),
                                        )
                                    )
                                    //getTimeDateUI(),
                                  ],
                                ),
                              ],
                            );
                          }, childCount: 1),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: ShopContestTabHeader(context,),
                    ),
                  ];
                },
                body: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        children: List.generate(shopList.length,
                                (index) {
                              return ShopListView(
                                //heroTag: shopData.shopCode+"$index",
                                onShopClick: () {
                                  if(index==0) {
                                    Navigator.push(context, ShopInfoScreen.route(
                                      shop: shopList.first.shop!,
                                      onMapClick: (){
                                        Navigator.push(context, MapSample.route(
                                          initialPosition: shopList[0].shop?.location,
                                        ));
                                      }
                                  ));
                                  } else if(index==1) {
                                    Navigator.push(context, ShopInfoScreen.route(
                                        shop: shopList[index].shop!,
                                        onMapClick: (){
                                          Navigator.push(context, MapSample.route(
                                            initialPosition: shopList[index].shop?.location,
                                          ));
                                        }
                                    ));
                                  }
                                },
                                onHueClick: () => onMapClickOpenPage(index),
                                onLikeClick: () {  },

                                shopItem: shopList[index],
                                //animation: animation,
                                //animationController: animationController,
                              );
                            }
                        )
                    ),
                  ),
                )
              /* Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                    //HotelAppTheme.buildLightTheme().backgroundColor,
                child: ListView.builder(
                  itemCount: hotelList.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final int count =
                        hotelList.length > 10 ? 10 : hotelList.length;
                   /* final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController,
                                curve: Interval(
                                    (1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));*/
                    //animationController.forward();
                    return ShopListView(
                      callback: () {},
                      hotelData: hotelList[index],
                      //animation: animation,
                      //animationController: animationController,
                    );
                  },
                ),*/
            ),
          ),

        ],
      ),
    );
  }

  Widget getSearchBarUI(context) {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          /// Search Entry Widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (Theme.of(context).brightness ==  Brightness.dark)
                      ? Colors.grey.shade300.withOpacity(0.70)
                      : Colors.white70,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Lubumbashi...',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /// Search button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),

            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  //FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: shopAppTheme.buildLightShopTheme.backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void showDemoDialog(context) {
    DateTime startDate = DateTime.now();

    DateTime endDate = DateTime.now().add(const Duration(days: 5));
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime? startData, DateTime? endData) {
          /*setState(() {
            if (startData != null && endData != null) {
              startDate = startData;
              endDate = endData;
            }
          });*/
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget getAppBarUI(context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back,
                      //color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Shops & Stores',
                  style: TextStyle(
                    //color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 50,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /*Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.favorite_border,
                              color: Theme.of(context).primaryColorDark,
                            )

                        ),
                      ),
                    ),
                  ),*/
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        Navigator.push(context, MapSample.route());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.locationDot,
                          //color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

class ShopContestTabHeader extends SliverPersistentHeaderDelegate {
  const ShopContestTabHeader(this.context,{this.onSearchDataEnter,});
  final BuildContext context;
  final Function()? onSearchDataEnter;



  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent) {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    return SizedBox(
      //color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                //color: HotelAppTheme.buildLightTheme().backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 8.0),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            ///color: HotelAppTheme.buildLightTheme().backgroundColor,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '32 bureau a louer disponible',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      onTap: () {
                        //FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => FiltersScreen(),
                              fullscreenDialog: true),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.sort,
                                  color: Theme.of(context).colorScheme.secondary //shopAppTheme.buildLightShopTheme.primaryColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Divider(
              height: 1,
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
