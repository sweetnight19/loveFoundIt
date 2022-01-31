import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<int> signInWithMail(String mail, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 1;
    } else if (e.code == 'wrong-password') {
      return 2;
    }
  }
  return 0;
}

Future<int> registerWithMail(String password, String mail, String username,
    String phone, String radioButtonItem) async {
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
      'gender': radioButtonItem,
      'biography': '',
      'cover': '',
      'instagram': '',
      'photo': '',
      'twitter': '',
      'cover':
          "https://www.elcampico.org/wp-content/uploads/2016/04/dummy-post-horisontal.jpg",
      'name': username,
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 2;
    } else if (e.code == 'email-already-in-use') {
      return 1;
    }
  }

  return 0;
}

void recoveryWithEmail(String mail) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: mail,
  );
}
