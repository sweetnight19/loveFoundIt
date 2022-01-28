// ignore_for_file: unused_import, unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_found_it/API/api.dart';
import 'package:love_found_it/main.dart';
import 'package:love_found_it/widgets/primary_button.dart';
import 'package:love_found_it/widgets/text_field.dart';

import '../custom_widget.dart';

class RegisterPageLess extends StatefulWidget {
  const RegisterPageLess({Key? key}) : super(key: key);

  @override
  _RegisterPageLessState createState() => _RegisterPageLessState();
}

class _RegisterPageLessState extends State<RegisterPageLess> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPageFull(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPageFull extends StatefulWidget {
  const RegisterPageFull({Key? key}) : super(key: key);

  @override
  _RegisterPageFullState createState() => _RegisterPageFullState();
}

class _RegisterPageFullState extends State<RegisterPageFull> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp())),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: Container(
                decoration: customBackground(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(children: <Widget>[
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please fill in the form below to register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordConfirmController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 50),
                  primaryButton('Registrarse', () async {
                    if (checkPassword(passwordController.text,
                        passwordConfirmController.text, context)) {
                      int result = await registerWithMail(
                          passwordController.text,
                          emailController.text,
                          usernameController.text,
                          phoneController.text);

                      switch (result) {
                        case 0:
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          //navigate to home
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                          );
                          break;
                        case 1:
                          checkRegisterAPI(
                              "The account already exists for that email",
                              context);

                          break;
                        case 2:
                          checkRegisterAPI(
                              'The password provided is too weak', context);
                          break;
                        default:
                          break;
                      }
                    }
                  }),
                ]))));
  }

  bool checkPassword(String text, String text2, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    if (text.length < 6) {
      scaffold.showSnackBar(const SnackBar(
        content: Text('Password must be at least 6 characters'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (text != text2) {
      scaffold.showSnackBar(const SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
  }

  void checkRegisterAPI(String text, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    ));
  }
}
