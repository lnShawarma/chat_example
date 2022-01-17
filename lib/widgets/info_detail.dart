// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration_screen_auth/domain/user.dart';
import 'package:registration_screen_auth/page/auth_page.dart';
import 'package:registration_screen_auth/model/model.dart';
import 'package:registration_screen_auth/service/authenticator.dart';

class UserInfoPage extends StatelessWidget {
  final UserModel userModelInfo;
  final String userInfoAut;
  const UserInfoPage({Key key, this.userModelInfo, this.userInfoAut}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter login demo',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              AuthentificatorService().logOut();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(50),
            child: const Center(
              child: Text(
                'Welcome',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,            
              children:  [
                Text('email: $userInfoAut'),
                const SizedBox(
                  height: 5,
                ),
                const Text('password: '),
              ],
            ),
          )
        ],
      ),
      //),
    );
  }

  // void _logoutOnRegistrationScreen(BuildContext context) async {
  //   Route route = MaterialPageRoute(builder: (context) => MyHomePage());
  //   final result = await Navigator.push(context, route);
  // }
}
