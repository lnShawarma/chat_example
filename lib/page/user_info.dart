// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration_screen_auth/domain/user.dart';
import 'package:registration_screen_auth/domain/user_from_firebase.dart';
import 'package:registration_screen_auth/page/auth_page.dart';
import 'package:registration_screen_auth/model/model.dart';
import 'package:registration_screen_auth/service/authenticator.dart';
import 'package:registration_screen_auth/service/database.dart';

class UserInfoPage extends StatefulWidget {
  final String userInfoAut;
  const UserInfoPage({Key key, this.userInfoAut}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  var db = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String> userEmail() async {
      var email = (await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get()).data()['email'].toString();
      return email;
    }
    Future<String> userPassword() async {
      var email = (await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get()).data()['password'].toString();
      return email;
    }
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
              children: [
                FutureBuilder(future: userEmail(), builder: (BuildContext context, AsyncSnapshot snapshot) {return Text('Email ${snapshot.data}');}, ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(future: userPassword(), builder: (BuildContext context, AsyncSnapshot snapshot) {return Text('Password ${snapshot.data}');}, ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

