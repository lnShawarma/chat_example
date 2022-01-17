// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:registration_screen_auth/domain/user.dart';
import 'package:registration_screen_auth/service/database.dart';

class AuthentificatorService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserInformation> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return UserInformation.fromFirebase(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<UserInformation> registerInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(email, password);
      return UserInformation.fromFirebase(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<UserInformation> get currentUser {
    return _firebaseAuth.authStateChanges().map((User user) => user != null ? UserInformation.fromFirebase(user) : null);
  }

}
