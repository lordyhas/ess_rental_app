import 'package:exploress_location/logic/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exploress_location/src/home_page/rental_stuff/model/rental_model.dart';
import 'package:exploress_location/src/home_page/rental_stuff/rental_stuff.dart';


class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late List<PopularFilterListData> popularFilterListData ;
  late List<PopularFilterListData> storeListData ;

  late RangeValues _values;
  late double distValue;
  late Filter filter;
  late bool isDarkMode;
  late final _text;

  Map<String, String> lang = <String, String>{
    "filter_title" : "Filters",
    "filter_apply" : "Apply",
    "filter_shop"  : "Type of shop",
    "filter_max_dist" : "Maximum distance from me",
    "filter_cat" : "Category filters",
    "filter_price" : "Price",

    "filter_slider_dist" : "Less than",

    "filter_list_" : "",
    "filter_" : "",

    "cat_electronic" : "Electronic Device",
    "cat_cloth" : "Clothes",
    "cat_cuisine" : "Cuisine",
    "cat_furniture" : "Furniture",
    "cat_" : "",
  };



  @override
  void initState() {
    super.initState();
    //text = lang as Map<String, String>;
    //text = BlocProvider.of<LanguageBloc>(context).state.getStrings();
    popularFilterListData = popularFList();
    storeListData = storeFilterList();
    filter = BlocProvider.of<FilterCubit>(context).state;
    //_values = const RangeValues(100, 600);
    _values =  RangeValues(filter.minPrice, filter.maxPrice);
    distValue = filter.maxDistance;

  }

  Color colorTitle(){
    return isDarkMode ? Colors.black54 : Colors.grey.shade700;
  }





  @override
  Widget build(BuildContext context) {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);
    isDarkMode = Theme.of(context).brightness == Brightness.dark ;


    return Scaffold(
      //appBar: AppBar(),
      //backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          getAppBarUI(),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      priceBarFilter(),
                      const Divider(height: 1),
                      popularFilter(),
                      const Divider(height: 1),
                      distanceViewUI(),
                      const Divider(height: 1),
                      shopFilterUI()
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 16, bottom: 16, top: 8),
            child: Container(
              height: 48,
              constraints: const BoxConstraints(maxWidth: 520),
              decoration: BoxDecoration(
                color: shopAppTheme.buildLightShopTheme.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),

              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      "Appliqué",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget shopFilterUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "Type de local",
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < storeListData.length; i++) {
      final PopularFilterListData date = storeListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: TextStyle(
                          //color: Theme.of(context).textTheme.subtitle2?.color
                      ),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? shopAppTheme.buildLightShopTheme.primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (storeListData[0].isSelected) {
        for (final d in storeListData) {
          d.isSelected = false;
        }
      } else {
        for (final d in storeListData) {
          d.isSelected = true;
        }
      }
    } else {
      storeListData[index].isSelected =
          !storeListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < storeListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = storeListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == storeListData.length - 1) {
        storeListData[0].isSelected = true;
      } else {
        storeListData[0].isSelected = false;
      }
    }
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "Maximum distance par rapport au centre ville",
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChangedistValue: (double value) {
            distValue = value;
            BlocProvider.of<FilterCubit>(context).change(
              maxDistance: value,
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "Categorie",
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getPList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList() {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData data = popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        data.isSelected = !data.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            data.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: data.isSelected
                                ? shopAppTheme.buildLightShopTheme.primaryColor
                                : Colors.grey.shade400,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            data.titleTxt,
                            //style: TextStyle(color: Theme.of(context).primaryColorDark),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceBarFilter() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Prix (en \$)',
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: [
            RangeSliderView(
              values: _values,
              onChangeRangeValues: (RangeValues values) {
                _values = values;
                BlocProvider.of<FilterCubit>(context).change(
                  maxPrice: values.end,
                  minPrice: values.start,
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget getAppBarUI() {

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        //color: shopAppTheme.buildLightShopTheme.backgroundColor,
        /*boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],*/
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
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Filtre",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  popularFList(){
    return <PopularFilterListData>[
      PopularFilterListData(
        titleTxt: "Bureau",
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: "Salle de fete",
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: "Salle de reunion",
        isSelected: true,
      ),
      PopularFilterListData(
        titleTxt: "Boutique",
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: "Grand espace",
        isSelected: false,
      ),
    ];
  }

  storeFilterList(){
    return <PopularFilterListData>[
      PopularFilterListData(
        titleTxt: 'Tout type',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'Dans le centre commercial',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'Avec caraux',
        isSelected: true,
      ),
      /*PopularFilterListData(
      titleTxt: 'Promotion',
      isSelected: false,
    ),*/
      PopularFilterListData(
        titleTxt: 'Avec plafond',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'SNEL & Regis, prise ne charge',
        isSelected: false,
      ),
    ];
  }


}
