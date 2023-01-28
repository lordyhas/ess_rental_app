import 'package:flutter/material.dart';

enum ErrorType{unknown, e404, offline,}

class OnErrorPage extends StatefulWidget {
  final ErrorType errorType;
  final Exception? error;
  const OnErrorPage({super.key, this.error, this.errorType = ErrorType.unknown});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const OnErrorPage());
  }

  @override
  State<OnErrorPage> createState() => _OnErrorPageState();
}

class _OnErrorPageState extends State<OnErrorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final RelativeRectTween _relativeRectTween = RelativeRectTween(
    begin: const RelativeRect.fromLTRB(24, 24, 24, 200),
    end: const RelativeRect.fromLTRB(24, 24, 24, 250),
  );

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //backgroundColor: const Color(0xffd8f3dc),
      body: Builder(
        builder: (context) {
          switch(widget.errorType){
            case ErrorType.e404:
              return Container();
            case ErrorType.offline:
              return Container();
            default:
              return Stack(
                children: [
                  PositionedTransition(
                    rect: _relativeRectTween.animate(_controller),
                    child: Image.asset('assets/img/brain.png'),
                  ),
                  Positioned(
                    top: 170,
                    bottom: 0,
                    left: 24,
                    right: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '404',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50,
                              letterSpacing: 2,
                              //color:  Color(0xff2f3640),
                              fontFamily: 'Anton',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sorry, we couldn\'t find the page!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            //color: Color(0xff2f3640),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );

          }

        }
      ),
    );
  }
}