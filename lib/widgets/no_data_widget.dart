

import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String data;
  const NoData({super.key, this.data = "No data" ,});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.not_interested, size: 62,),
        Text(data),
      ],
    );
  }
}
