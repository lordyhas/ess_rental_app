part of home_page;

class ShopHomeScreen extends StatefulWidget {


  final List<ShopItemData> shopList;
  final void Function()? onMenuTap;

  const ShopHomeScreen({
    required this.shopList,
    super.key,
    this.onMenuTap,
  });

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen>
    with TickerProviderStateMixin {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  AnimationController? animationController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness _currentBrightness = Theme.of(context).brightness;

    var images = [
      "assets/img/pub_headset.jpeg",
      "assets/img/pub_sofa.jpeg",
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
    void onMapClickOpenPage(int index) {
      Navigator.push(
          context,
          MapSample.route(
            initialPosition: widget.shopList[index].shop?.location,
          ));
    }

    return Material(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      child: Column(
        children: <Widget>[
          Expanded(
            child: NestedScrollView(
                //controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              child: Image.asset(
                                images.elementAt(Random().nextInt(2)),
                                //colorBlendMode: BlendMode,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                gaplessPlayback: true,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              //MediaQuery.of(context).size.width,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            Column(
                              children: <Widget>[
                                getSearchBarUI(context),
                                /*Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: const Text(
                                      "Find a shop near to you, Exploress",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white70),
                                    )),*/
                                getTimeDateUI(context),
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
                      delegate: ShopContestTabHeader(
                        context,
                      ),
                    ),
                  ];
                },
                body: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Wrap(
                        spacing: 8.0,
                        //runSpacing: 8.0,
                        alignment: WrapAlignment.center,
                        //runAlignment: WrapAlignment.center,
                        children:
                            List.generate(widget.shopList.length, (index) {
                          return ShopListView(
                            //heroTag: shopData.shopCode+"$index",
                            onShopClick: () {
                              if (index == 0) {
                                Navigator.push(
                                    context,
                                    ShopInfoScreen.route(
                                        shop: widget.shopList.first.shop!,
                                        onMapClick: () {
                                          Navigator.push(
                                              context,
                                              MapSample.route(
                                                initialPosition: widget
                                                    .shopList[0].shop?.location,
                                              ));
                                        }));
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    ShopInfoScreen.route(
                                        shop: widget.shopList[index].shop!,
                                        onMapClick: () {
                                          Navigator.push(
                                              context,
                                              MapSample.route(
                                                initialPosition: widget
                                                    .shopList[index]
                                                    .shop
                                                    ?.location,
                                              ));
                                        }));
                              }
                            },
                            onHueClick: () => onMapClickOpenPage(index),
                            onLikeClick: () {},

                            shopItem: widget.shopList[index],
                            //animation: animation,
                            //animationController: animationController,
                          );
                        })),
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
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? Colors.grey.shade300.withOpacity(0.70)
                      : Colors.white70,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: const InputDecoration(
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

  void showDemoDialog({required BuildContext context}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => Dialog(
        //constraints: const BoxConstraints(maxWidth: 720, maxHeight: 1020),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: kMediumDimens),
          child: CalendarPopupView(
            barrierDismissible: true,
            minimumDate: DateTime.now(),
            maximumDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day + 10),
            initialEndDate: endDate,
            initialStartDate: startDate,
            onApplyClick: (DateTime startData, DateTime endData) {
              setState(() {
                startDate = startData;
                endDate = endData;
              });
            },
            onCancelClick: () {},
          ),
        ),
      ),
    );
  }



  Widget getTimeDateUI(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
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
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choisir un date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
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
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Numbre des Chambres',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '3 Chambre - 2 Adultes',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
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
        ],
      ),
    );
  }
}

class ShopContestTabHeader extends SliverPersistentHeaderDelegate {
  const ShopContestTabHeader(
    this.context, {
    this.onSearchDataEnter,
  });

  final BuildContext context;
  final Function()? onSearchDataEnter;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
                              builder: (BuildContext context) =>
                                  FiltersScreen(),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary //shopAppTheme.buildLightShopTheme.primaryColor
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
