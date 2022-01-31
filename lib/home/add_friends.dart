import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddFriendFull extends StatefulWidget {
  const AddFriendFull({Key? key}) : super(key: key);

  @override
  _AddFriendFullState createState() => _AddFriendFullState();
}

class _AddFriendFullState extends State<AddFriendFull> {
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'AÑADIR AMIGO',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.pink[200],
      body: ListView(
        children: [
          const SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: idController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Introduce el ID del amigo",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              child: ElevatedButton(
                onPressed: () {
                  try {
                    FirebaseFirestore.instance
                        .collection("profile")
                        .doc(idController.text)
                        .get();

                    FirebaseFirestore.instance
                        .collection("profile")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'friends': FieldValue.arrayUnion([idController.text])
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    checkAddFriendAPI("Este ID no existe", context);
                  }
                },
                child: const Text("ENVIAR"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
              )),
          const SizedBox(
            height: 250,
          ),
          const Center(
            child: Text("Tu ID:"),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SelectableText(
              FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  void checkAddFriendAPI(String text, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    ));
  }
}
