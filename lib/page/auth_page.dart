// @dart=2.9
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:registration_screen_auth/domain/user.dart';
import 'package:registration_screen_auth/model/model.dart';
import 'package:registration_screen_auth/page/user_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_screen_auth/model/model.dart';
import 'package:registration_screen_auth/page/user_info.dart';
import 'package:registration_screen_auth/service/authenticator.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool hidePass = true;

  final AuthentificatorService _authentificatorService = AuthentificatorService();

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailFocus = FocusNode(), _passFocus = FocusNode();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  UserModel newUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: AppBar(
      //  title: Text(widget.title),
      // ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocus,
                autofocus: true,
                onFieldSubmitted: (contex) {
                  _changeFocus(context, _emailFocus, _passFocus);
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  labelStyle: TextStyle(color: Colors.blue),
                  hintText: 'Enter a email address',
                  hintStyle: TextStyle(color: Colors.blue),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                validator: _validateEmail,
                onSaved: (value) => newUser.email = value,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                focusNode: _passFocus,
                autofocus: false,
                controller: _passController,
                obscureText: hidePass,
                decoration: const InputDecoration(
                  labelText: 'Password *',
                  labelStyle: TextStyle(color: Colors.blue),
                  hintText: 'Enter the password',
                  hintStyle: TextStyle(color: Colors.blue),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                validator: _validatePassword,
                onSaved: (value) => newUser.password = value,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _loginUser, child: const Text("Sign In")),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                      onPressed: () {
                        _registrationUser();
                      },
                      child: const Text("Sign Up")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _changeFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void dispoce() {
    _emailController.dispose();
    _passController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Enter the password';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }

  void _showMessage({@required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
        )));
  }

    Future _registrationUser() async {
      if (_formKey.currentState.validate()) {
        UserInformation user = await _authentificatorService.registerInWithEmailAndPassword(_emailController.text.trim(), _passController.text.trim());
                if (user == null) {
          _showMessage(message: "Can't signIn you! Please check you email and password");
        } else {
          _emailController.clear();
          _passController.clear();
        }
      } 
    }
  

  Future _loginUser() async {
     if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        UserInformation user = await _authentificatorService.signInWithEmailAndPassword(_emailController.text.trim(), _passController.text.trim());
        if (user == null) {
          _showMessage(message: "Can't signIn you! Please check you email and password");
        } else {
          _emailController.clear();
          _passController.clear();
        }
     }
  }
}
