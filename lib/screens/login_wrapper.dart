import 'package:copeiros/models/user.dart';
import 'package:copeiros/screens/authenticate/authenticate.dart';
import 'package:copeiros/screens/home/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Login Wrapper
class LoginWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser>(context);
    print(user);
    //return Home or Authenticate
    if(user == null || !user.firebaseUser.isEmailVerified){
      return Authenticate();
    }else{
      return HomeWrapper(uid: user.uid, email: user.firebaseUser.email);
    }
  }
}
