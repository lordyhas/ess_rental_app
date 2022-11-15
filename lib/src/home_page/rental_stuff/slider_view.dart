part of rental.stuff;




class SliderView extends StatefulWidget {
  const SliderView({
    required this.onChangeDistValue,
    required this.distValue,
    super.key,
  });

  final Function(double) onChangeDistValue;
  final double distValue;

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  double distValue = 00.0;

  @override
  void initState() {
    distValue = widget.distValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: distValue.round(),
              child: const SizedBox(),
            ),
            SizedBox(
              width: 170,
              child: Text(
                '${ " Moins de ${((distValue* maximumDistanceMeter)/100000).toStringAsFixed(1)}"} Km',
                textAlign: TextAlign.center,
                //style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
            Expanded(
              flex: 100 - distValue.round(),
              child: const SizedBox(),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: CustomThumbShape(),
          ),
          child: Slider(
            onChanged: (double value) {
              setState(() {
                distValue = value;
              });
              try {
                widget.onChangeDistValue(distValue);
              } catch (_) {}
            },
            min: 0,
            max: 100, //maximumDistanceMeter/1000,
            activeColor: shopAppTheme.buildLightShopTheme.primaryColor,
            inactiveColor: Colors.grey.withOpacity(0.4),
            divisions: 100,
            value: distValue,
          ),
        ),
      ],
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 3.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    canvas.drawPath(
        Path()
          ..addOval(Rect.fromPoints(
              Offset(center.dx + 12, center.dy + 12),
              Offset(center.dx - 12, center.dy - 12)))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = Colors.black.withOpacity(0.5)
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(8)));

    final Paint cPaint = Paint();
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.drawCircle(Offset(center.dx, center.dy), 12, cPaint);
    cPaint..color = colorTween.evaluate(enableAnimation)!;
    canvas.drawCircle(Offset(center.dx, center.dy), 10, cPaint);
  }

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}
