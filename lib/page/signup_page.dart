import 'package:flutter/material.dart';
import 'package:shopflutter/widgets/custom_scaffold.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Text("Sing up"),
    );
  }
}
