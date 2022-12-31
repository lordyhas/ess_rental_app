part of home_page;

class SettingScreen extends StatefulWidget {
  static const routeName = "SettingScreen";
  final Function()? onMenuTap;

  const SettingScreen({
    super.key,
    this.onMenuTap,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notification = false;
  bool mail = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context).onPushScreen(NavigationScreen.setting);
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 32.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 910),
            child: Column(
              children: [
                SizedBox(
                  height: 560,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(top: 50.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.person),
                                  title: const Text("Modifier le profile"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    /*Go.to(context,
                                        page: const ProfilePage(),
                                        routeName: ProfilePage.routeName);*/

                                    if (!kIsWeb) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Scaffold(
                                            appBar: AppBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0.0,
                                              centerTitle: true,
                                              leading: IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              title: const Text("Profile info"),
                                            ),
                                            body: const SingleChildScrollView(
                                                child: ProfilePage()),
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => SizedBox(
                                        child: AlertDialog(
                                            scrollable: true,
                                            title: Row(
                                              children: [
                                                const Icon(Icons.close,
                                                  color: Colors.transparent,
                                                ),
                                                const Spacer(),
                                                const Text("Profile info"),
                                                const Spacer(),
                                                IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ),
                                            content: const SizedBox(
                                              width: kMediumDimens,
                                              child: ProfilePage(),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.password),
                                  title: const Text("Modifier le mot de passe"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.space_dashboard),
                                  title: const Text("Accéder à MySpace"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () =>  Go.of(context).to(routeName: UserSpace.routeName),

                                ),
                                ListTile(
                                  leading: const Icon(Icons.message),
                                  title: const Text("Message et Chat"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.map),
                                  title: const Text("Mon adresse"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.credit_card),
                                  title: const Text("Mode de payement"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.output),
                                  title: const Text("Se deconnecter"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: (){
                                    BlocProvider.of<AuthenticationBloc>(context).logout();
                                    GoRouter.of(context).goNamed(LoginPage.routeName);
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  "assets/img/profile3.jpg" ,
                                  height: 100,
                                )),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const SelectableText("Unknown Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                )),
                            const SelectableText(
                              "guest-user@exploress.com",
                              style: TextStyle(color: Colors.white60),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text("Dark Mode"),
                          trailing: Switch(
                            value: true,
                            onChanged: (bool value) {},
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text("Notification"),
                          trailing: Switch(
                            value: notification,
                            onChanged: (bool value) {
                              setState(() {
                                notification = value;
                              });
                            },
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.mail_rounded),
                          title: const Text("Avis via mail"),
                          subtitle: const Text("M'envoyer des avis par mail"),
                          trailing: Switch(
                            value: mail,
                            onChanged: (bool value) {
                              setState(() {
                                mail = value;
                              });
                            },
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.more_horiz),
                          title: const Text("More"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          //leading: const Icon(Icons.dark_mode),
                          title: const Text("About Us"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        ListTile(
                          //leading: const Icon(Icons.dark_mode),
                          title: const Text("About this app"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Go.of(context).to(routeName: AboutPage.routeName);
                          },
                        ),

                        /*ListTile(
                          //leading: const Icon(Icons.dark_mode),
                          title: const Text("Help"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),*/
                        FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                  leading: const Icon(Icons.launch_sharp),
                                  title: const Text("Last Update"),
                                  subtitle: Text(
                                      "version beta : ${snapshot.data?.version} "),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                );
                              }

                              return Container();
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
