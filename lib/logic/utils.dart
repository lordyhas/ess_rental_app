import 'package:exploress_location/logic/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AppConstant{
  static const name = "KodishApp";
  static const shortname = "Kodisha";
  static const fullname = "Tsheleka KodishApp";
  static const completeName = "Kodisha Application";
  static const markName = "Exploress Kodisha";
  static const organisationName = "Exploress";
  static const developer = "Hassan K.";
  static const developerId = "lordyhas";
  static const developerOrg = "KDynamic Lab";
}


class _Title extends StatelessWidget {
  final String text;
  final double? fontSize;
  const _Title(this.text,{this.fontSize,Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!kIsWeb) return Container();
    return Column(
      children: [
        //const SizedBox(height: 32.0,),
        Row(
          children: [
            Text('Home',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
              ),
            ),
            BooleanBuilder(
                condition: () => fontSize != null,
                ifTrue: const Icon(Icons.arrow_forward_ios),
                ifFalse: const Icon(Icons.chevron_right),
            ),

            Text(text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
              ),
            ),
            if(text.isNotEmpty)
            BooleanBuilder(
              condition: () => fontSize != null,
              ifTrue: const Icon(Icons.arrow_forward_ios),
              ifFalse: const Icon(Icons.chevron_right),
            ), //arrow_forward_ios
          ],
        ),
        //const SizedBox(height: 32.0,),
      ],
    );
  }
}

class H1 extends _Title {
  const H1(String data,{Key? key}) : super(data,fontSize: 24, key: key);
}

class H2 extends _Title {
  const H2(String data,{Key? key}) : super(data,fontSize: 18,key: key);
}

class RouteNameTitle extends StatelessWidget {
  final double? fontSize;
  final String text;
  const RouteNameTitle(this.text,{Key? key, this.fontSize}) : super(key: key);
  
  List<String> get titles => text.split('/')
      .map((str)=> str.trim())
      .where((e)=> e.isNotEmpty).toList(); //text.split('/').toList()..removeAt(0);

  @override
  Widget build(BuildContext context) {
    if(!kIsWeb) return Container();
    
    return Column(
      children: [
        //const SizedBox(height: 32.0,),
        Row(
          children: [
            for(String str in titles)
              ...[
                Text(str.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
                BooleanBuilder(
                  condition: () => fontSize != null,
                  ifTrue: const Icon(Icons.arrow_forward_ios),
                  ifFalse: const Icon(Icons.chevron_right),
                ),
              ]
          ]
        ),
        //const SizedBox(height: 32.0,),
      ],
    );
  }
}




