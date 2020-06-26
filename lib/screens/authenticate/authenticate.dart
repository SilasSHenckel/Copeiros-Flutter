import 'package:copeiros/screens/authenticate/register.dart';
import 'package:copeiros/screens/authenticate/reset_password.dart';
import 'package:copeiros/screens/authenticate/sign_in.dart';
import 'package:copeiros/shared/layout_constants.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  String currentAuthScreen = signInKey;
  bool showSingIn = true;

  void toggleView(String mCurrentAuthScreen){
    setState(() => currentAuthScreen = mCurrentAuthScreen);
  }

  @override
  Widget build(BuildContext context) {
    if(currentAuthScreen == signInKey) return SignIn(toggleView: toggleView);
    if(currentAuthScreen == resetPasswordKey) return ResetPassword(toggleView: toggleView);
    return Register(toggleView: toggleView);
  }
}
