import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> signInWithMail(String mail, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    print(userCredential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 1;
    } else if (e.code == 'wrong-password') {
      return 2;
    }
  }
  return 0;
}

Future<int> registerWithMail(
    String password, String mail, String username, String phone) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );

    FirebaseFirestore.instance
        .collection('profile')
        .doc(userCredential.user!.uid)
        .set({
      'username': username,
      'mail': mail,
      'phone_number': phone,
      'biography': '',
      'cover': '',
      'instagram': '',
      'photo': '',
      'twitter': '',
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 2;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 1;
    }
  } catch (e) {
    print(e);
  }

  return 0;
}

void recoveryWithEmail(String mail) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: mail,
  );
}
