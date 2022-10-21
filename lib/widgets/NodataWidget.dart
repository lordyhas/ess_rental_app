

import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String data;
  NoData({this.data = "No data" ,});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.not_interested, size: 62,),
          Text(this.data),
        ],
      ),
    );
  }
}
