library login_page;

import 'package:exploress_rental/widgets/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:exploress_rental/logic/values.dart';

import 'package:exploress_rental/src/home_page.dart';

part 'login_page/login_form.dart';

part 'login_page/button_and_input.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/my_account/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  bool  underline = true;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool createAccount = false;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ));
    }
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => LoginCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: BackgroundUI(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          /*appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),*/
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SizedBox(
              child: Container(
                height: size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: !kIsWeb? null : const NeverScrollableScrollPhysics(),
                  child: BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.status.isSubmissionFailure) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('Authentication Failure'),
                            ),
                          );
                      }
                    },
                    child: Opacity(
                      opacity: _opacity.value,
                      child: Transform.scale(
                        scale: _transform.value,
                        child: Container(
                          constraints: kLoginBoxConstraints,
                          width: size.width * .9,
                          height:kIsWeb ? size.height * 0.8 : 620,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(.1),
                                blurRadius: 90,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0).copyWith(),
                                    child: Image.asset(
                                      'assets/icon_app.png',
                                      //color: Theme.of(context).primaryColor.withOpacity(0.85),
                                      height: 120,
                                    ),
                                  ),
                                  Row(
                                    children: const [
                                      SizedBox(),
                                      Spacer(),
                                      SelectableText(
                                        "Welcome to ${AppConstant.name}",
                                        //'Welcome to Tsheleka KodishApp',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          //color: Theme.of(context).primaryColor.withOpacity(.7),
                                        ),
                                      ),
                                      Spacer(),

                                      SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(),
                                  const _EmailInput(
                                    key: Key('loginForm_emailInput'),
                                  ),
                                  const _PasswordInput(
                                    key: Key('loginForm_passwordInput'),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const ButtonLogin(text: 'Connecter',),
                                      SizedBox(width: size.width / 25),
                                      Container(
                                        //width: 150,
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: (){
                                            Log.i('Forgotten password! button pressed',);
                                            GoRouter.of(context)
                                                .pushReplacementNamed(
                                              HomePage.routeName
                                            );
                                          },

                                          onHover: (value){
                                            setState(() {
                                              underline = value;
                                            });
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Mot de passe oublié !',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  decoration: underline
                                                      ? TextDecoration.underline
                                                      : TextDecoration.none,
                                              ),
                                              //recognizer: TapGestureRecognizer()..onTap = ,
                                            ),
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                  //const SizedBox(),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32.0
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        _GoogleLoginButton(),
                                         SizedBox(height: 8.0,),
                                        _FacebookLoginButton(),
                                      ],
                                    ),
                                  ),
                                 // const SizedBox(),
                                  RichText(
                                    text: const TextSpan(
                                      text: 'S\'enregistrer',
                                      style: TextStyle(
                                        //color: Colors.white70, //Theme.of(context).primaryColor.withOpacity(.8),
                                        fontSize: 15,
                                      ),
                                        //recognizer: TapGestureRecognizer()..onTap = (){},
                                      //mouseCursor: SystemMouseCursors.text,
                                    ),
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: IconButton(
                                      onPressed: !kIsWeb ? (){
                                        /*goto(context,
                                            page : const SettingPage(),
                                            routeName:  SettingPage.routeName
                                        );*/
                                      } : null,
                                      icon: const Icon(CupertinoIcons.gear_solid,
                                        color:  !kIsWeb
                                            ? Colors.white
                                            : Colors.transparent,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}



