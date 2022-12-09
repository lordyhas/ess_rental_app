part of home_page;

class AnchorLayout extends StatelessWidget {
  final Widget child;

  const AnchorLayout({required this.child, Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final ScrollController _scrollController = ScrollController();
    if(!kIsWeb) return child;
    return NestedScrollView(
      //controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Image.asset([
                          "assets/img/bg_material_1.jpg",
                          "assets/img/bg_material_3.jpg",
                          "assets/img/bg_material_2.jpg",
                          "assets/img/bg_material_3.jpg",
                          "assets/img/bg_material_2.jpg",
                        ].elementAt(Random().nextInt(4)),
                          //colorBlendMode: BlendMode,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          gaplessPlayback: true,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        //MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.6),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          //getSearchBarUI(context),
                          /// ----------------- Search Part --------------
                          Container(
                            //width: 500,
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  /// Search Entry Widget
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                                      child: Container(

                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300.withOpacity(0.70),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(38.0),
                                          ),
                                          /*boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              offset: const Offset(0, 2),
                                              blurRadius: 8.0),
                                        ],*/
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),//only(left: 16, right: 16, top: 4, bottom: 4),
                                          child: Container(
                                            //constraints: const BoxConstraints(maxWidth: 400),
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
                                  ),

                                  /// Search button
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
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
                                        child: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(
                                            FontAwesomeIcons.magnifyingGlass,
                                            size: 20,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16.0),
                              child: const Text(
                                "Find a product for rent, "
                                    "${AppConstant.shortname}",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white70),
                              )),
                          //getTimeDateUI(context),
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
            delegate: ContestTabHeader(context),
          ),
        ];
      },
      body: child,
    );
  }

  // ignore: non_constant_identifier_names

}


class ContestTabHeader extends SliverPersistentHeaderDelegate {
  const ContestTabHeader(this.context, {
    this.onSearchDataEnter,
    this.secondary = false,
    this.title,
  });

  final bool secondary;
  final Text? title;
  final BuildContext context;
  final Function()? onSearchDataEnter;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    //final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    //print("xxxxxxxxxxxxxxxxxxxxxxxx => "+title!.data!);
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
                   Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<NavigationController, NavigationScreen>(
                        builder: (context, state) {
                          switch(state){
                            case NavigationScreen.home:
                            case NavigationScreen.explorer:
                              return const H3("");
                            case NavigationScreen.setting:
                              return const H3("Setting");
                            case NavigationScreen.myspace:
                              return const H3("MySpace");
                          }
                          //return Container();
                        },
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
                              const FiltersScreen(),
                              fullscreenDialog: true),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            const Text(
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
                                      .floatingActionButtonTheme
                                      .backgroundColor,
                                //shopAppTheme.buildLightShopTheme.primaryColor
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


