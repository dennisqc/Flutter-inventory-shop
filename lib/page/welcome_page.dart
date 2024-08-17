import 'package:flutter/material.dart';
import 'package:shopflutter/loggin/signin_page.dart';
import 'package:shopflutter/loggin/signup_page.dart';
import 'package:shopflutter/styles/styles.dart';
import 'package:shopflutter/widgets/custom_scaffold.dart';
import 'package:shopflutter/widgets/welcome_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Bienvenido \n",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                      TextSpan(
                          text: "PERSONAL OK! COMPU",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600))
                    ]))),
          )),
          Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                      child: WelcomeButton(
                        ButtonText: "Registrte",
                        onTap: SignupPage(),
                        color: Colors.transparent,
                        TextColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: WelcomeButton(
                        ButtonText: "iniciar sesion",
                        onTap: SigninPage(),
                        color: Colors.white,
                        TextColor: lightColorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
