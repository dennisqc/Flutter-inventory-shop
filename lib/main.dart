import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopflutter/firebase_options.dart';
import 'package:shopflutter/page/inventory_page.dart';
import 'package:shopflutter/page/list_product_item.dart';
import 'package:shopflutter/page/welcome_page.dart';
import 'package:shopflutter/styles/styles.dart';

void main() async {
  // try {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: WelcomePage(),
    theme: lightMode,
    debugShowCheckedModeBanner: false,
  ));
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  // }
}
