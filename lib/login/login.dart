import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:love_found_it/home/home.dart';
import 'package:love_found_it/login/sign_with_mail.dart';
import 'package:sign_button/sign_button.dart';

import '../custom_widget.dart';
import 'recovery.dart';

class LoginPageFull extends StatefulWidget {
  const LoginPageFull({Key? key}) : super(key: key);

  @override
  _LoginPageFullState createState() => _LoginPageFullState();
}

class _LoginPageFullState extends State<LoginPageFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
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
                              onPressed: () async {
                                var aux = await signInWithGoogle();

                                //check if user is already in database
                                var user = await FirebaseFirestore.instance
                                    .collection('profile')
                                    .doc(aux.user!.uid)
                                    .get();

                                if (!user.exists) {
                                  FirebaseFirestore.instance
                                      .collection('profile')
                                      .doc(aux.user!.uid)
                                      .set({
                                    'uid': aux.user!.uid,
                                    'username': aux.user!.displayName,
                                    'name': aux.user!.displayName,
                                    'mail': aux.user!.email,
                                    'phone_number': "",
                                    'gender': "",
                                    'biography': '',
                                    'cover': '',
                                    'instagram': '',
                                    'photo': '',
                                    'twitter': '',
                                    'friends': [],
                                    'cover':
                                        'https://www.elcampico.org/wp-content/uploads/2016/04/dummy-post-horisontal.jpg',
                                  });
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeFull(),
                                  ),
                                );
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
                const SizedBox(height: 150),
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
