import 'package:flutter/material.dart';

class RegisterPageLess extends StatefulWidget {
  const RegisterPageLess({Key? key}) : super(key: key);

  @override
  _RegisterPageLessState createState() => _RegisterPageLessState();
}

class _RegisterPageLessState extends State<RegisterPageLess> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RegisterPageFull(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.pink[200],
      ),
    );
  }
}

class RegisterPageFull extends StatefulWidget {
  const RegisterPageFull({Key? key}) : super(key: key);

  @override
  _RegisterPageFullState createState() => _RegisterPageFullState();
}

class _RegisterPageFullState extends State<RegisterPageFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: const Center(
        child: Text('RegisterPageFull'),
      ),
    );
  }
}
