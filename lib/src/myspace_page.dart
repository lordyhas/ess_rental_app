
import 'package:exploress_location/logic/values.dart';
import 'package:flutter/material.dart';

class UserSpacePage extends StatefulWidget {
  static const routeName = "/home/user/my_space";
  const UserSpacePage({Key? key}) : super(key: key);

  @override
  State<UserSpacePage> createState() => _UserSpacePageState();
}

class _UserSpacePageState extends State<UserSpacePage> {

  TextStyle get numStyle => const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle get textStyle => const TextStyle(fontSize: 20, color: Colors.white70);

  @override
  Widget build(BuildContext context) {
    double boxWidth = 100.0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black12,
        title: const Text("MySpace"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          constraints: const BoxConstraints(maxWidth: kMediumDimens),
          child: Column(
            children: [
              const SizedBox(height: 32.0,),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("assets/avatar/avatar_1.png", fit: BoxFit.cover,),
                ),
                title: const Text("Unknown Name"),
                subtitle: const Text("guest-user@exploress.com"),
              ),

              const SizedBox(height: 32.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){},
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      height: 75,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage("assets/img/bg_image_web.jpeg"),
                            fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.grey,
                              BlendMode.color)
                        ),
                      ),
                      constraints: const BoxConstraints(
                          maxWidth: 200,),
                      child: Column(
                        children: const [
                          Spacer(),
                          Text("À faire loué",
                            style: TextStyle(fontSize: 20,color: Colors.white70),
                          ),
                          Text("18", style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){},
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      height: 75,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage("assets/img/bg_image_web.jpeg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.grey,
                                BlendMode.color)
                        ),
                      ),
                      constraints: const BoxConstraints(
                          maxWidth: 200,),
                      child: Column(
                        children:  const [
                          Spacer(),
                          Text("Déjà loué",
                            style: TextStyle(fontSize: 20,color: Colors.white70),
                          ),
                          Text("4",style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0,),

              Container(
                //constraints: const BoxConstraints(maxHeight: 200),
                height: 300,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/img/bg_material_2.jpg"),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(20),
                  //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],

                ),

                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(maxWidth: 150,),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: boxWidth,
                            child: Column(
                              children: [
                                 Text("Vue",
                                  style: textStyle,
                                ),
                                Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "4",
                                          style: numStyle
                                      ),
                                      const TextSpan(
                                        text: "",
                                      )
                                    ]
                                )),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(maxWidth: 150),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: boxWidth,
                            child: Column(
                              children: [
                                Text("Like",
                                  style: textStyle,
                                ),

                                Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "496",
                                          style: numStyle
                                      ),
                                      const TextSpan(
                                        text: "\$",
                                      )
                                    ]
                                )),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(maxWidth: 150,),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: boxWidth,
                            child: Column(
                              children:  [
                                Text("Déjà loué",
                                  style: textStyle,
                                ),

                                Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "4",
                                          style: numStyle
                                      ),
                                      const TextSpan(
                                        text: "\$",
                                      )
                                    ]
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(maxWidth: 150),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: boxWidth,
                            child: Column(
                              children: [
                                Text("Espace",
                                  style: textStyle,
                                ),
                                Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "240",
                                          style: numStyle
                                      ),
                                      const TextSpan(
                                        text: "Mb",
                                      )
                                    ]
                                )),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(maxWidth: 150),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: boxWidth,
                            child: Column(
                              children: [
                                Text("Frais",
                                  style: textStyle,
                                ),

                                Text.rich(TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "4",
                                      style: numStyle
                                    ),
                                    const TextSpan(
                                        text: "\$",
                                    )
                                  ]
                                )),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(maxWidth: 150),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: boxWidth,
                            child: Column(
                              children: [
                                const Text("Gain",
                                  style: TextStyle(color: Colors.white70),
                                ),

                                Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "1250",
                                          style: numStyle
                                      ),
                                      const TextSpan(
                                        text: "\$",
                                      )
                                    ]
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
