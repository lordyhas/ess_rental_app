import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _Title extends StatelessWidget {
  final String text;
  final double? fontSize;
  const _Title(this.text,{this.fontSize,Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!kIsWeb) return Container();
    return Column(
      children: [
        const SizedBox(height: 32.0,),
        Row(
          children: [
            Text('Home',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize ?? 24,
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
            Text(text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize ?? 24,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, ), //arrow_forward_ios
          ],
        ),
        const SizedBox(height: 32.0,),
      ],
    );
  }
}

class H1 extends _Title {
  const H1(String data,{Key? key}) : super(data,key: key);
}

class H2 extends _Title {
  const H2(String data,{Key? key}) : super(data,fontSize: 18,key: key);
}

