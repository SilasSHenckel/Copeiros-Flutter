import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copeiros/models/user.dart';
import 'package:copeiros/screens/home/user_basic_info.dart';
import 'package:copeiros/screens/home/home.dart';
import 'package:copeiros/services/user_service.dart';
import 'package:copeiros/shared/loading.dart';
import 'package:flutter/material.dart';

class HomeWrapper extends StatefulWidget {

  final String uid;
  final String email;
  HomeWrapper({this.uid, this.email});

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  
  User _user = new User();
  bool _userVerified = false;

  void setUserVerified(bool value){
    setState(() => _userVerified = value);
  }

  Future getUser() async {
    if(!_userVerified) {
      _userVerified = true;
      Firestore.instance.collection(User.COLLECTION).document(widget.uid).get().then((DocumentSnapshot documentSnapshot) {
        setState(() {
          _user = UserService.userFromDocument(documentSnapshot);
        });
      });
    }
  }

  Widget isBasicUserInfoOk(User user){
    if(user != null && user.sex.isNotEmpty && user.name.isNotEmpty && user.nickName.isNotEmpty && user.age.isNotEmpty){
      return Home();
    }
    return UserBasicInfo(user: user, uid: widget.uid, email: widget.email, setUserVerified: setUserVerified);
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    
    if(_user != null && _user.email == null) return Loading();

    return isBasicUserInfoOk(_user);
  }
}
