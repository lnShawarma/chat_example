// @dart=2.9
import 'package:meta/meta.dart';

class UserInfoFromFirebase {
  String uid;
  String email;
  String password;

  UserInfoFromFirebase({this.uid, this.email, this.password});

  UserInfoFromFirebase.fromFireBase(String uid, Map<String, dynamic> data) {
    uid = uid;
    email = data['email'];
    password = data['password'];
  }
}