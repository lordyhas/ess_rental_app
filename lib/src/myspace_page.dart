library myspace_page;

import 'dart:math';

import 'package:exploress_rental/data_test.dart';
import 'package:exploress_rental/logic/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySpacePage extends StatelessWidget {
  const MySpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black12,
        title: const Text("MySpace"),
      ),
      body: UserSpaceScreen(
        key: key,
      ),
    );
  }
}

class UserSpaceScreen extends StatelessWidget {
  static const routeName = "/home/user/my_space";

  const UserSpaceScreen({Key? key}) : super(key: key);

  TextStyle get numStyle =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  TextStyle get textStyle =>
      const TextStyle(fontSize: 20, color: Colors.white70);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.myspace);
    double boxWidth = 100.0;
    final ScrollController scrollController = ScrollController();

    return Material(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  constraints: const BoxConstraints(maxWidth: 1280),
                  //const BoxConstraints(maxWidth: kMediumDimens),
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 8.0,
                    children: [
                      //const SizedBox(height: 32.0,),
                      //const H1("MySpace"),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        constraints: const BoxConstraints(
                          maxWidth: kPhoneDimens,
                        ),
                        height: 320,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                          //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],
                        ),
                        child: Column(
                          children: [
                            BooleanBuilder(
                              condition: () => state.status == AuthenticationStatus.authenticated,
                              ifTrue: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    "${state.user.photoMail}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title:  Text("${state.user.name}"),
                                subtitle:
                                 Text("${state.user.email}"),
                              ),
                              ifFalse: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/img/profile3.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: const Text("Unknown Name"),
                                subtitle:
                                const Text("guest-user@exploress.space"),
                              ),
                            ),

                            const SizedBox(
                              height: 32.0,
                            ),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {},
                                  child: Container(
                                    margin: const EdgeInsets.all(4.0),
                                    height: 75,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/img/bg_image_web.jpeg"),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.grey, BlendMode.color)),
                                    ),
                                    constraints: const BoxConstraints(
                                      maxWidth: 200,
                                    ),
                                    child: Column(
                                      children: const [
                                        Spacer(),
                                        Text(
                                          "À faire loué",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white70),
                                        ),
                                        Text("18",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {},
                                  child: Container(
                                    margin: const EdgeInsets.all(4.0),
                                    height: 75,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/img/bg_image_web.jpeg"),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.grey, BlendMode.color)),
                                    ),
                                    constraints: const BoxConstraints(
                                      maxWidth: 200,
                                    ),
                                    child: Column(
                                      children: const [
                                        Spacer(),
                                        Text(
                                          "Déjà loué",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white70),
                                        ),
                                        Text(
                                          "4",
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 16.0,),
                      Container(
                        //constraints: const BoxConstraints(maxHeight: 200),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        constraints:
                            const BoxConstraints(maxWidth: kPhoneDimens),
                        height: Responsive.of(context).isPhone ? 400 : 320,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/img/bg_material_2.jpg"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20),
                          //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],
                        ),

                        child: Container(
                          child: Column(
                            children: [
                              Row(),
                              const Spacer(),

                              //const Spacer(),
                              //const ListTile(),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    constraints: const BoxConstraints(
                                      maxWidth: 150,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: boxWidth,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Vue",
                                            style: textStyle,
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "4", style: numStyle),
                                            const TextSpan(
                                              text: "",
                                            )
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: boxWidth,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Like",
                                            style: textStyle,
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "496", style: numStyle),
                                            const TextSpan(
                                              text: "\$",
                                            )
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    constraints: const BoxConstraints(
                                      maxWidth: 150,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: boxWidth,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Déjà loué",
                                            style: textStyle,
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "4", style: numStyle),
                                            const TextSpan(
                                              text: "\$",
                                            )
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: boxWidth,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Espace",
                                            style: textStyle,
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "240", style: numStyle),
                                            const TextSpan(
                                              text: "Mb",
                                            )
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: boxWidth,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Frais",
                                            style: textStyle,
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "4", style: numStyle),
                                            const TextSpan(
                                              text: "\$",
                                            )
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: boxWidth,
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Gain",
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "1250", style: numStyle),
                                            const TextSpan(
                                              text: "\$",
                                            )
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              //const Spacer(),
                              //const ListTile(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        //constraints: const BoxConstraints(maxHeight: 200),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8.0),
                        constraints: Responsive.of(context).size.width > 1363
                            ? null
                            : const BoxConstraints(maxWidth: kPhoneDimens),
                        //height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                          //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],
                        ),

                        child: Container(
                          child: Column(
                            children: [
                              //const SizedBox(height: 1,child: Expanded(child: SizedBox(width: 10,),),),
                              const ListTile(
                                title: Text(
                                  "Mes Produits",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Wrap(
                                runAlignment: WrapAlignment.start,
                                alignment: WrapAlignment.start,
                                children: DataTest.shops
                                    .map((e) => SizedBox(
                                          width: 400,
                                          child: ListTile(
                                            leading: Image.asset(
                                              e.imagePath!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            title: Text(
                                              e.shopName,
                                              style: const TextStyle(),
                                            ),
                                            subtitle: Text(
                                                "Prix: ${(Random().nextInt(40) + 20 * (e.rater * e.rating)).toInt()}\$"),
                                            onTap: () {},
                                          ),
                                        ))
                                    .toList(),
                              ),
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
        },
      ),
    );
  }
}
