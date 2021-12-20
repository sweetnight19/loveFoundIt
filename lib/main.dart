import 'package:flutter/material.dart';
import 'package:love_found_it/custom_widget.dart';
import 'package:love_found_it/login/recovery.dart';
import 'package:love_found_it/widgets/primary_button.dart';

import 'login/login.dart';
import 'login/register.dart';
import 'widgets/secondary_button.dart';

//Firebase
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Love Found it',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[200],
        body: Center(
          child: Container(
            decoration: custom_background(),
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
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: secondaryButton('CREAR UNA CUENTA', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPageLess(),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Row(children: const [SizedBox(height: 20)]),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: primaryButton('INICIAR SESSION', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPageFull(),
                            ),
                          );
                        }),
                      ),
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
}
