// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_screen_auth/domain/user_from_firebase.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String userEmail, String userPassword) async {
    return await usersCollection.doc(uid).set({
      'email': userEmail,
      'password': userPassword,
    });
  }

  List<UserInfoFromFirebase> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInfoFromFirebase(
        email: doc.get('email'),
        password: doc.get('password'),
      );
    }).toList();
  }

  Stream<List<UserInfoFromFirebase>> getUsers(String id) {
    return usersCollection.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) =>
            UserInfoFromFirebase.fromFireBase(doc.id, doc.data()))
        .toList());
  }

  //Future<UserInfoFromFirebase> getUser(String id)

  Future<UserInfoFromFirebase> getUser(String id) async {
    var doc = await usersCollection.doc(uid).get();
    return UserInfoFromFirebase.fromFireBase(doc.id, doc.data());
  }
}
