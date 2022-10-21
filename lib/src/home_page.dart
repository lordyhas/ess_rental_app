import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarColor: Colors.transparent,
      //statusBarIconBrightness: Theme.of(context).brightness,
      systemNavigationBarColor: Theme.of(context).backgroundColor,
    ));*/
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.ellipsis_vertical)
          )
        ],
      ),
      drawer: Drawer(
        child: ListBody(
          children: List.generate(5, (index) => ListTile(
            leading: const Icon(CupertinoIcons.app),
            title: Text("Item $index"),
            subtitle: Text("Sub item $index"),
          )),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Placeholder(),
            SizedBox(height: 8.0,),
            Placeholder(),
            SizedBox(height: 8.0,),
            Placeholder(),
            SizedBox(height: 8.0,),
            Placeholder(),
            SizedBox(height: 8.0,),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}


/*
 Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(

        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.1,
            height: MediaQuery.of(context).size.height, 
            child: Container(
              color: Colors.green,
              child: Column(
                children: [
                  Ink
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(),
            ),
          ),
        ],
      ),
    );
*/
