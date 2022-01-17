// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:registration_screen_auth/page/auth_page.dart';

class UserInformation {
   String id;
   String userEmail;

  UserInformation.fromFirebase(User user){
    id = user.uid;
    userEmail = user.email;
  }
}

