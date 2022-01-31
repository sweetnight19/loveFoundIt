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
  String radioButtonItem = 'M';
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'REGISTRO',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: Container(
                decoration: customBackground(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    'Por favor complete el siguiente formulario para registrarse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                      filled: true,
                      fillColor: Colors.white,
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
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Confirmar Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Número de teléfono",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'M';
                            id = 1;
                          });
                        },
                      ),
                      const Text(
                        'HOMBRE',
                      ),
                      Radio(
                        value: 2,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'F';
                            id = 2;
                          });
                        },
                      ),
                      const Text(
                        'MUJER',
                      ),
                    ],
                  ),
                  const ListTile(
                    title: Text(
                      'Al hacer clic en registrarse, acepta nuestros Términos, Política de datos y Política de cookies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  primaryButton('Registrarse', () async {
                    if (checkPassword(passwordController.text,
                        passwordConfirmController.text, context)) {
                      int result = await registerWithMail(
                          passwordController.text,
                          emailController.text,
                          usernameController.text,
                          phoneController.text,
                          radioButtonItem);

                      switch (result) {
                        case 0:
                          await FirebaseAuth.instance
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
                              "La cuenta ya existe para ese correo electrónico",
                              context);

                          break;
                        case 2:
                          checkRegisterAPI(
                              'La contraseña proporcionada es demasiado débil',
                              context);
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
        content: Text('La contraseña debe tener al menos 6 caracteres'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (text != text2) {
      scaffold.showSnackBar(const SnackBar(
        content: Text('Las contraseñas no coinciden'),
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
