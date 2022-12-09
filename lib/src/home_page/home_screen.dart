part of home_page;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool underline = false;

  double h1Size() {
    if (Responsive.of(context).isPhone) {
      return 28;
    } else if (Responsive.of(context).size.width < 720) {
      return 28;
    } else if (Responsive.of(context).size.width < 854) {
      return 28;
    } else if (Responsive.of(context).size.width < 1080) {
      return 32;
    } else if (Responsive.of(context).size.width < 1280) {
      return 42;
    } else if (Responsive.of(context).size.width < 1680) {
      return 54;
    } else if (Responsive.of(context).size.width < 1920) {
      return 54;
    }
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/img/bg_image_web.jpeg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    const SizedBox( height: 8.0,),
                    ListTile(
                      title: SelectableText(
                        AppConstant.name,
                        style: TextStyle(fontSize: h1Size()),
                      ),
                      subtitle: const SelectableText(
                          "Voulez-vous faire louer votre bien mobilier et immoblier ?"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 32.0),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.white),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Faire louer",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            onPressed: () => Go.to(
                                context,
                                page: const AddRentPage(),
                                routeName: AddRentPage.routeName
                            ),
                          ),
                          TextButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Besoin d'aide",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        //letterSpacing: underline ? .0 : null,
                                        fontWeight: underline
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        decoration: underline
                                            ? TextDecoration.underline
                                            : TextDecoration.none
                                    ),
                                  ),
                                  const TextSpan(
                                    text: " ?",
                                    style: TextStyle(
                                        fontSize: 18.0,

                                    ),
                                  ),
                                ]
                              )
                              ),
                            ),
                            onHover: (value) {
                              setState((){
                                underline = value;
                              });
                            },
                            onPressed: (){},
                            onLongPress: (){},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0,),
            Card(
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                      horizontalTitleGap: 32.0,
                      leading: const Icon(
                        CupertinoIcons.home,
                        size: 42,
                      ),
                      title: const SelectableText(
                        "Hall Rental",
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      subtitle: null,
                      trailing: const Icon(CupertinoIcons.chevron_right_2),
                      onTap: () {},
                    ),
                    /*const Markdown(data: "Dans cette catégorie, veuillez trouver des :"
                        "- maisons à louer "
                        "- appartements à louer "
                        "- salles des fêtes à louer"
                        "- magasins à louer"
                        "- entrepots à louer"
                        "- etc..."),*/
                    const SizedBox(
                      height: 16.0,
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                      horizontalTitleGap: 32.0,
                      leading: const Icon(
                        CupertinoIcons.rectangle_stack_fill,
                        size: 42,
                      ),
                      title: const SelectableText(
                        "Apartment Rental",
                        style: TextStyle(fontSize: 24.0),
                      ),
                      subtitle: null,
                      trailing: const Icon(CupertinoIcons.chevron_right_2),
                      onTap: () {},
                    ),
                    /*const Markdown(data: "Dans cette catégorie, veuillez trouver des : "
                        "- un bureau  à louer"
                        "- salle des réunion à louer"
                        "- un espace de travail à louer"
                        "- une boutique à louer"
                        "- etc..."),*/

                    const SizedBox(
                      height: 16.0,
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                      horizontalTitleGap: 32.0,
                      leading: const Icon(
                        CupertinoIcons.car_detailed,
                        size: 42,
                      ),
                      title: const SelectableText(
                        "Car Rental",
                        style: TextStyle(fontSize: 24.0),
                      ),
                      subtitle: null,
                      trailing: const Icon(CupertinoIcons.chevron_right_2),
                      onTap: () {},
                    ),
                    /*const Markdown(data: """ "Dans cette catégorie, veuillez trouver des : "
                        "- un vehicule à 2 roues (categorie A) à louer"
                        "- une vehicule categorie B à louer"
                        "- un bus pour tranporter de travailleur"
                        "- un bus scolaire et autres "
                        "- un trackteur à louer"
                        "- etc..." """),*/
                  ],
                ),
              ),
            ),

            /*SizedBox(
              height: 500,
              width: 400,
              child: const MarkdownBody(data:  "Dans cette catégorie, veuillez trouver des : "
                          "* un vehicule à 2 roues (categorie A) à louer"
                          "* une vehicule categorie B à louer"
                          "* un bus pour tranporter de travailleur"
                          "* un bus scolaire et autres "
                          "* un trackteur à louer"
                          "* etc..." ),
            ),*/
          ],
        ),
      ),
    );
  }
}
