import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_found_it/home/add_friends.dart';
import 'package:love_found_it/profile/profile.dart';
import 'package:path/path.dart';

class ListFull extends StatefulWidget {
  const ListFull({Key? key}) : super(key: key);

  @override
  _ListFullState createState() => _ListFullState();
}

class _ListFullState extends State<ListFull> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('profile').snapshots();

  String uid = FirebaseAuth.instance.currentUser!.uid;
  List<dynamic> friends = [];

  @override
  void initState() {
    getFriends();
    super.initState();
  }

  void getFriends() async {
    Stream documentStream =
        FirebaseFirestore.instance.collection('profile').doc(uid).snapshots();

    documentStream.listen((data) {
      friends = data.data()["friends"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'HOME',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Algo salió mal :(');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Cargando...");
              }

              return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                if (friends.contains(data["uid"].toString())) {
                  if (data['gender'] == 'M') {
                    return ListTile(
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.network(data["photo"]).image)),
                      ),
                      trailing: const Icon(Icons.assignment_ind_rounded),
                      title: Text(data['username']),
                      subtitle: Text(data['mail']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePageFull(
                              uuid: data['uid'].toString(),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListTile(
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.network(data["photo"]).image)),
                      ),
                      trailing: const Icon(Icons.assignment_ind_rounded),
                      title: Text(data['username']),
                      subtitle: Text(data['mail']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePageFull(
                              uuid: data['uid'].toString(),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Container();
                }
              }).toList());
            }),
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



        /*
        ListView.builder(
          itemBuilder: (BuildContext buildContext, int index) {
            return ListTile(
              title: Text(
                friendsList[index].name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(friendsList[index].email),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
          itemCount: friendsList.length,
        ),
        */




        /*
        StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['gender'] == 'M') {
                  return ListTile(
                    leading: const Icon(
                      Icons.male_rounded,
                      color: Colors.blue,
                    ),
                    trailing: const Icon(Icons.assignment_ind_rounded),
                    title: Text(data['username']),
                    subtitle: Text(data['mail']),
                  );
                } else {
                  return ListTile(
                    leading: const Icon(
                      Icons.female_rounded,
                      color: Colors.pink,
                    ),
                    trailing: const Icon(Icons.assignment_ind_rounded),
                    title: Text(data['username']),
                    subtitle: Text(data['mail']),
                  );
                }
              }).toList());
            }),
         */