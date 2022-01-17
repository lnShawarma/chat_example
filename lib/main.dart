// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_screen_auth/domain/user.dart';
import 'package:registration_screen_auth/page/auth_page.dart';
import 'package:registration_screen_auth/page/interim_page.dart';
import 'package:registration_screen_auth/service/authenticator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserInformation>.value(
      value: AuthentificatorService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InterimPage(),
      ),
    );
  }
}
