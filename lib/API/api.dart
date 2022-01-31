import 'package:firebase_auth/firebase_auth.dart';

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

void registerWithMail(String password, String mail) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );
    sendEmail();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

void sendEmail() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
    print('Email sent');
  }
}

void recoveryWithEmail(String mail) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: mail,
  );
}
