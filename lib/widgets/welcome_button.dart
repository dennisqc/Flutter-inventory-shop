import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key, this.ButtonText, this.onTap, this.color, this.TextColor});
  final String? ButtonText;
  final Widget? onTap;
  final Color? color;
  final Color? TextColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (e) => onTap!));
      },
      child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: color!,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
              )),
          child: Text(
            ButtonText!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: TextColor),
          )),
    );
  }
}
