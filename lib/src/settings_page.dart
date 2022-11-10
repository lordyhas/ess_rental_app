part of home_page;

class SettingPage extends StatefulWidget {


  final Function()? onMenuTap;
  const SettingPage({super.key, this.onMenuTap, });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool notification = false;
  bool mail = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 32.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 910),
            child: Column(
              children: [
                SizedBox(
                  height: 450,
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
                                  title: const Text("Profile info"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.password),
                                  title: const Text("Mot de passe"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.map),
                                  title: const Text("Mon addresse"),
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
                                  onTap: () {},
                                ),
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
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset("assets/img/profile3.jpg",
                                height: 100,
                              )
                            ),
                            const SizedBox(height: 16.0,),
                            const SelectableText("Unknown Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                )
                            ),
                            const SelectableText("guest-user@sfr.com",
                              style: TextStyle(color: Colors.white60),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    margin:const EdgeInsets.all(8.0),
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
                    margin:const EdgeInsets.all(8.0),
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
                          onTap: () {},
                        ),
                        FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                  leading: const Icon(Icons.more_horiz),
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
