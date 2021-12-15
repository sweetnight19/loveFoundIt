import 'package:flutter/material.dart';

class LoginPageLess extends StatelessWidget {
  const LoginPageLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const LoginPageFull(),
        theme: ThemeData(scaffoldBackgroundColor: Colors.pink[200]));
  }
}

class LoginPageFull extends StatefulWidget {
  const LoginPageFull({Key? key}) : super(key: key);

  @override
  _LoginPageFullState createState() => _LoginPageFullState();
}

class _LoginPageFullState extends State<LoginPageFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: const Center(
        child: Text('LoginPageFull'),
      ),
    );
  }
}
