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
      // Inicia el proceso de autenticación con Google
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        // Si la cuenta es nula, significa que el usuario canceló la autenticación
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Autenticación con Google cancelada')),
        );
        return;
      }

      // Obtiene la autenticación de Google
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Credenciales de Firebase
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Inicia sesión con las credenciales de Firebase
      User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        // Navega a la página principal si la autenticación fue exitosa
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryPage(),
          ),
        );
      }
    } catch (e) {
      // Manejo de errores durante la autenticación
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
