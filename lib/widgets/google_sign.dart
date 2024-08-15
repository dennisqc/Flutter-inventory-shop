import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shopflutter/page/inventory_page.dart';

class GoogleSign extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
 
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Autenticación con Google cancelada')),
        );
        return;
      }

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryPage(),
          ),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de inicio de sesión con Google: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => signInWithGoogle(context),
      child: Brand(Brands.google),
    );
  }
}
