import 'dart:io';


import 'package:exploress_location/logic/values.dart';
import 'package:exploress_location/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';



class AboutPage extends StatefulWidget{
  static const routeName = '/home/setting/about';

  const AboutPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage>{

  var timeUpdate = DateTime.now();
  String appVersion = "0.2.0";

  @override
  void initState() {
    super.initState();
    //initPlatformPackageInfo();
    //PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //appVersion = packageInfo.version;

  }


  /*void initPlatformPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    //appVersion = packageInfo.version;
    //String buildNumber = packageInfo.buildNumber;
  }*/



  @override
  Widget build(BuildContext context) {
    ///text =  BlocProvider.of<LanguageBloc>(context).state.strings;
    ///
    var primaryTextStyle20 = Theme.of(context)
        .textTheme.bodyText2!
        .copyWith(fontSize: 17, /*fontWeight: FontWeight.bold*/);
    var textSettingsStyle = TextStyle(color: Colors.blue[600]);


    return WillPopScope(
      onWillPop: ()=> Future.value(true),
      child: BackgroundUI(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          //backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),

            //textTheme: Theme.of(context).textTheme,
            title: const Text('About',),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0,),
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: kMediumDimens),
                child: Column(

                  children: <Widget>[
                    const SizedBox(height: 82,),
                    Card(
                      //color: background2,
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const SizedBox(height: 16.0,),
                              SizedBox(
                                height: 150,
                                child: Image.asset("assets/icon_app.png"),
                              ),
                              const SizedBox(height: 8.0,),
                              Text(
                                "${AppConstant.completeName} (${AppConstant.name})",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: 24),
                              ),
                              const Text("kodisha@exploress.space",),

                            ],),
                          ),
                          FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {

                              String version = snapshot.data?.version ?? "";
                              String number = snapshot.data?.buildNumber ?? "";
                              return ListTile(
                                leading: const Icon(Icons.info),
                                title: Text("Version", style: primaryTextStyle20,),
                                subtitle: Text("$version+$number (non-stable)",),

                              );
                            }
                          ),
                          ListTile(
                            leading: const Icon(Icons.update),
                            title: Text('Update', style: primaryTextStyle20,),
                            subtitle: Text("${timeUpdate.subtract(const Duration(days: 35, hours: 1))}",
                            ),
                            onTap: (){},
                          ),
                          ListTile(
                            leading: const Icon(Icons.sync),
                            title: Text("Changelog",style: primaryTextStyle20,),
                            onTap: (){
                              //showAboutDialog(context: context);
                            },
                          ),

                          ListTile(
                            leading: const Icon(Icons.turned_in_not),
                            title: Text('Licence',style: primaryTextStyle20,),
                            onTap: (){
                              showLicensePage(context: context);
                            },
                          ),

                          ListTile(
                            leading: const Icon(Icons.share),
                            title: Text('Share this app',style: primaryTextStyle20,),
                            onTap: (){
                              Share.share(
                                  'check out my favorite app Rental App: \n'
                                      'https://hassankajila.com',
                                  subject: 'Look what I find!'
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.more_horiz),
                            title: Text('More app',style: primaryTextStyle20,),
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),

                    Card(
                      //color: background2,
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                      child: Column(
                        children: <Widget>[

                          ListTile(
                            title: Text("Developer ",style: textSettingsStyle,),
                          ),
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.user),
                            title: Text("Hassan K.",style: primaryTextStyle20,),
                            subtitle: const Text("@lordyhas"), //Text("dev.haspro@gmail.com",),
                            onTap: () async {
                              final Uri url = Uri.parse("https://linktr.ee/hassankajila");
                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },

                          ),
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.googlePlay),
                            title: Text("Google Play Store",style: primaryTextStyle20,),
                          ),

                          ListTile(
                            leading: const Icon(Icons.group_outlined),
                            title: Text("Our team",style: primaryTextStyle20,),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      //color: background2,
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                      child: Column(
                        children: <Widget>[

                          ListTile(
                            title: Text("Company",style: textSettingsStyle,),
                          ),
                          ListTile(
                            leading: const Icon(Icons.business),
                            title: Text("KDynamic Lab.",style: primaryTextStyle20,),
                            subtitle: const Text("Mobile App Developers ",),
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text('Address',style: primaryTextStyle20,),
                            subtitle: const Text("None ",),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }

}