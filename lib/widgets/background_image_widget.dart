

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class BackgroundCover extends StatelessWidget {
  const BackgroundCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
       kIsWeb?"assets/img/bg_image2.jpg" : "assets/img/bg_image3.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}


class BackgroundUI extends StatelessWidget {
  final Widget child;
  const BackgroundUI({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          BackgroundCover(key: key,),
          Container(
              child: child
          )
        ],
      ),
    );
  }
}



