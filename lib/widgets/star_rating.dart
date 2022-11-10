import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final bool allowHalfRating;
  final double rating;
  final double size;
  final Color color;
  final Color? borderColor;

  const StarRating({
      Key? key,
      required this.starCount,
      this.allowHalfRating = true,
      this.rating = 0,
      this.size = 15,
      this.color = Colors.amber,
      this.borderColor
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:List<Icon>.generate(starCount, (index) {
          double value = rating - index.toDouble();
          //print('StarRating(index => $index : $value) ####');
          if(value > 1)
            return Icon(Icons.star, color: color, size: size,);
          else if(value > 0 && value < 1){
            return Icon(Icons.star_half_outlined, color: color, size: size,);
          }
          else
            return Icon(Icons.star_border, color: color, size: size,);

        }) ,
      ),
    );
  }
}
