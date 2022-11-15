
import 'package:exploress_location/logic/values.dart';
//import 'package:exploress/pages/profiles/maps_test.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart' as dist;

import 'package:exploress_location/logic/model/data_model.dart';


/*
class QuickSingleShop extends StatefulWidget {
  final ShopData shop;
  final void Function()? onMapClick;

  const QuickSingleShop({Key? key, required this.shop, this.onMapClick})
      : super(key: key);

  @override
  _QuickSingleShopState createState() => _QuickSingleShopState();

  static Route route({
    Key? key,
    required ShopData shop,
    required void Function()? onMapClick
  }) {
    return MaterialPageRoute<void>(builder: (_) => QuickSingleShop(
      shop: shop,
      onMapClick: onMapClick,
      key: key,
    ));
  }
}

class _QuickSingleShopState extends State<QuickSingleShop> {
  //bool likeActive = false;

  @override
  Widget build(BuildContext context) {
    var position = BlocProvider.of<MapsBloc>(context).state.maps;

    //widget.shop.rater;
    var textStyle =
    Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.bodyText2,
        elevation: 0.0,
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        title: Text('About ${widget.shop.shopName}',
          //style: Theme.of(context).textTheme.bodyText2,
        ),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(FontAwesomeIcons.times),
        ),
        actions: [
          IconButton(
            onPressed:(){
              Navigator.push(context, MapSample.route(
                initialPosition: widget.shop.location,
              ));
            },
            icon: const Icon(FontAwesomeIcons.map),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            Container(
              child: Container(
                height: size.width * 0.75,
                width: size.width * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(widget.shop.imagePath!),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "${widget.shop.shopName}",
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  /*Text(
                    "\$${widget.shop.}",
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),*/
                  SelectableText(
                    "${distance(
                        fromLatLng: position.currentLatLngFromDistance,
                        toLatLng: dist.LatLng(-11.6284708, 27.487585))} km near to you",
                    style: textStyle.copyWith(
                        fontSize: 16,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Column(
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorLight,
                        ),
                        onPressed: widget.onMapClick!,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Find on Maps"),
                        )
                    ),
                    /**OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            side: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor
                            ),
                          //minimumSize: ,
                        ),
                        onPressed: (){},
                        child: Text("Show products")
                    ),*/


                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Spacer(flex: 2,),

          ],
        ),
      ),
    );
  }
}
*/