import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListLess extends StatelessWidget {
  const ListLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ListFull extends StatefulWidget {
  const ListFull({Key? key}) : super(key: key);

  @override
  _ListFullState createState() => _ListFullState();
}

class _ListFullState extends State<ListFull> {
  String getUsername() {
    String username = "TEST";

    FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => username = value.get("username").toString());
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Text(getUsername())));
  }
}
