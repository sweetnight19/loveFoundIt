import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_found_it/widgets/primary_button.dart';
import 'package:path/path.dart' as path;

class EditProfilePageFull extends StatefulWidget {
  final String? uuid;

  const EditProfilePageFull({this.uuid, Key? key}) : super(key: key);

  @override
  _EditProfilePageFullState createState() => _EditProfilePageFullState();
}

class _EditProfilePageFullState extends State<EditProfilePageFull> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String radioButtonItem = 'M';

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final biographyController = TextEditingController();
  final twitterController = TextEditingController();
  final instagramController = TextEditingController();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((profile) => {
              nameController.text = profile.get('name'),
              biographyController.text = profile.get('biography'),
              phoneController.text = profile.get('phone'),
              twitterController.text = profile.get('twitter'),
              instagramController.text = profile.get('instagram'),
            });
  }

  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        FirebaseFirestore.instance
            .collection('profile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'photo': await storage.ref(fileName).getDownloadURL()});

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () => _upload('camera'),
                    icon: const Icon(Icons.camera),
                    label: const Text('camera')),
                ElevatedButton.icon(
                    onPressed: () => _upload('gallery'),
                    icon: const Icon(Icons.library_add),
                    label: const Text('Gallery')),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: biographyController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter biography',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter phone number',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: twitterController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter the twitter',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: instagramController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter instagram',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem = 'M';
                        });
                      },
                    ),
                    const Text(
                      'HOMBRE',
                    ),
                    Radio(
                      value: 2,
                      groupValue: 1,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem = 'F';
                        });
                      },
                    ),
                    const Text(
                      'MUJER',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: primaryButton(
                            'Update profile',
                            () => {
                                  FirebaseFirestore.instance
                                      .collection('profile')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({
                                    'name': nameController.text,
                                    'biography': biographyController.text,
                                    'phone': phoneController.text,
                                    'instagram': instagramController.text,
                                    'twitter': twitterController.text
                                  })
                                }))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
