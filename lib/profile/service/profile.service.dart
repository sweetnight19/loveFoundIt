import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_found_it/profile/model/profile.dart';

class ProfileService {

  static const String _collection = 'profile';

  static Future<Profile?> queryProfile(String uuid) async {
    return getInstance().doc(uuid).get().then((snapshot) => snapshot.data());
  }

  static CollectionReference<Profile> getInstance() {
    return FirebaseFirestore.instance
        .collection(_collection)
        .withConverter<Profile>(
          fromFirestore: (snapshot, _) => Profile.fromJson(snapshot.data()!),
          toFirestore: (profile, _) => profile.toJson(),
        );
  }
}
