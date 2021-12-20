import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_found_it/widgets/primary_button.dart';

class SignInLess extends StatelessWidget {
  const SignInLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SingInFull());
  }
}

class SingInFull extends StatefulWidget {
  const SingInFull({Key? key}) : super(key: key);

  @override
  _SingInFullState createState() => _SingInFullState();
}

class _SingInFullState extends State<SingInFull> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'INICIAR SESIÓN',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: mailController,
                decoration: const InputDecoration(
                  hintText: 'Correo electrónico',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: primaryButton("INICIAR SESIÓN", () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: mailController.text,
                              password: passwordController.text);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  })),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )));
  }
}
