import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_found_it/home/add_friends.dart';

class ListFull extends StatefulWidget {
  const ListFull({Key? key}) : super(key: key);

  @override
  _ListFullState createState() => _ListFullState();
}

class _ListFullState extends State<ListFull> {
  var profile;

  @override
  void initState() {
    getInfo();
  }

  void getInfo() async {
    profile = await FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print("friendssss: " + profile.get('friends')[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        //body: ListView.builder(itemBuilder: (BuildContext buildContext,int index){buildBody(buildContext, index))},itemCount: profile.get('friends').length,);
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddFriendFull()));
          },
          child: const Icon(Icons.add),
          elevation: 0.0,
          backgroundColor: Colors.pink[500],
        ));
  }
}

/*
ListTile(
          title: Text(profile.get("username")),
          subtitle: Text(profile.get("phone_number").toString()),
          trailing: Icon(Icons.arrow_forward_ios),
        ),*/ 