import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:love_found_it/login/sign_with_mail.dart';
import 'package:sign_button/sign_button.dart';

import '../custom_widget.dart';
import 'recovery.dart';

class LoginPageLess extends StatelessWidget {
  const LoginPageLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPageFull());
  }
}

class LoginPageFull extends StatefulWidget {
  const LoginPageFull({Key? key}) : super(key: key);

  @override
  _LoginPageFullState createState() => _LoginPageFullState();
}

class _LoginPageFullState extends State<LoginPageFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Center(
          child: Container(
            decoration: customBackground(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 50,
                        ),
                      ),
                      Text("Love found it",
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                    ]),
                const SizedBox(height: 100),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: Text(
                    "Al pulsar Crear cuenta o Iniciar sesión, aceptas nuestros términos y condiciones. Obtén más informacion sobre cómo procesamos tus datos en nuestra política de privacidad y cookies.",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: SignInButton(
                              buttonType: ButtonType.google,
                              onPressed: () {
                                signInWithGoogle();
                              })),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: SignInButton(
                              buttonType: ButtonType.appleDark,
                              onPressed: () {})),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: SignInButton(
                            buttonType: ButtonType.mail,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SingInFull(),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecoveryFull(),
                        ),
                      );
                    },
                    child: const Text("¿Olvidaste tu contraseña?",
                        style: TextStyle(color: Colors.white, fontSize: 15))),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
