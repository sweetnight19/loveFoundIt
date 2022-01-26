import 'package:flutter/material.dart';

class ProfilePageFull extends StatefulWidget {
  const ProfilePageFull({Key? key}) : super(key: key);

  @override
  _ProfilePageFullState createState() => _ProfilePageFullState();
}

class _ProfilePageFullState extends State<ProfilePageFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center());
  }
}