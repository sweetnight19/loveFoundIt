import 'package:flutter/material.dart';
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
          elevation: 0
        ),
        body: Center(
            child: Container(
                decoration: custom_background(),
                child: ListView(children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Please fill in the form below to register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  textField('Passsword', true),
                  SizedBox(height: 40),
                  textField('Confirm passsword', true),
                  SizedBox(height: 40),
                  textField('Email'),
                  SizedBox(height: 40),
                  textField('Phone Number'),
                  SizedBox(height: 40),
                  primaryButton('Registrarse')
                ])
            )
        )
    );
  }

  void onRegister() {
    print('heyeyyeey');
  }
}
