import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProfilePageFull extends StatefulWidget {
  final String? uuid;

  const EditProfilePageFull({this.uuid, Key? key}) : super(key: key);

  @override
  _EditProfilePageFullState createState() => _EditProfilePageFullState();
}

class _EditProfilePageFullState extends State<EditProfilePageFull> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent
        ),
        body: ListView(
            padding: EdgeInsets.zero,
            children: []));
  }
}