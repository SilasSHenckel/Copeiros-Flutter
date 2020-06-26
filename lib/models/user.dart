import 'package:firebase_auth/firebase_auth.dart';

class User{

  static const String COLLECTION = 'users';
  static const String EMAIL = 'Email';
  static const String NAME = 'Name';
  static const String NICK_NAME = 'NickName';
  static const String SEX = 'Sex';
  static const String AGE = 'Age';

  final String uid;

  String email;
  String name;
  String nickName;
  String sex;
  String age;

  User({this.uid, this.email, this.name, this.nickName, this.sex, this.age});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      User.EMAIL : this.email,
      User.NAME : this.name ?? '',
      User.NICK_NAME : this.nickName ?? '',
      User.SEX : this.sex ?? '',
      User.AGE : this.age ?? ''
    };
    return map;
  }

}

class AuthUser{

  final String uid;
  FirebaseUser firebaseUser;

  AuthUser({this.uid, this.firebaseUser});
}