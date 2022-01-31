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
                child: ListView(children: <Widget>[
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please fill in the form below to register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: passwordConfirmController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  textField('Phone Number'),
                  const SizedBox(height: 40),
                  primaryButton('Registrarse', () {
                    if (checkPassword(passwordController.text,
                        passwordConfirmController.text, context)) {
                      registerWithMail(
                          passwordController.text, emailController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                      );
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
}
