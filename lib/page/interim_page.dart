// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_screen_auth/domain/user.dart';
import 'package:registration_screen_auth/page/auth_page.dart';
import 'package:registration_screen_auth/page/user_info.dart';

class InterimPage extends StatelessWidget {
  const InterimPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final UserInformation user = Provider.of<UserInformation>(context);
      final bool isLoggedIn = user != null;

      return isLoggedIn ? UserInfoPage(userInfoAut: user.id,) : MyHomePage();
    
  }
}