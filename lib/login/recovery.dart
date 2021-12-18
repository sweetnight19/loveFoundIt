import 'package:flutter/material.dart';

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
        body: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
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
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {},
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
        )));
  }
}
