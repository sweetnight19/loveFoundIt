import 'package:flutter/material.dart';
import 'package:love_found_it/API/api.dart';
import 'package:love_found_it/home/home.dart';

class SignInLess extends StatelessWidget {
  const SignInLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SingInFull());
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
        body: SingleChildScrollView(
            child: Form(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.visiblePassword,
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
              child: ElevatedButton(
                onPressed: () async {
                  int result = await signInWithMail(
                      mailController.text, passwordController.text);
                  switch (result) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeFull(),
                        ),
                      );
                      break;
                    case 1:
                      checkLogin("No user found for that email", context);
                      break;
                    case 2:
                      checkLogin(
                          "Wrong password provided for that user", context);
                      break;
                    default:
                  }
                },
                child: const Text(
                  "INICIAR SESIÓN",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ))));
  }

  void checkLogin(String text, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    ));
  }
}
