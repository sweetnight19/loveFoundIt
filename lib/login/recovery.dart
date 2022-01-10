import 'package:flutter/material.dart';
import 'package:love_found_it/API/api.dart';

class RecoveryLess extends StatelessWidget {
  const RecoveryLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RecoveryFull());
  }
}

class RecoveryFull extends StatefulWidget {
  const RecoveryFull({Key? key}) : super(key: key);

  @override
  _RecoveryFullState createState() => _RecoveryFullState();
}

class _RecoveryFullState extends State<RecoveryFull> {
  final mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Recupera tu cuenta',
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
          mainAxisAlignment: MainAxisAlignment.end,
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
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                recoveryWithEmail(mailController.text);
              },
              child: const Text(
                "ENVIAR CORREO",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ))));
  }
}
