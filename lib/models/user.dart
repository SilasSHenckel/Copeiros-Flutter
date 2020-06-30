import 'package:firebase_auth/firebase_auth.dart';

class User{

  static const String COLLECTION = 'users';
  static const String EMAIL = 'Email';
  static const String NAME = 'Name';
  static const String NICK_NAME = 'NickName';
  static const String SEX = 'Sex';
  static const String AGE = 'Age';
  static const String IMAGE_URL = 'ImageUrl';

  final String uid;

  String email;
  String name;
  String nickName;
  String sex;
  String age;
  String imageUrl;

  User({this.uid, this.email, this.name, this.nickName, this.sex, this.age, this.imageUrl});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      User.EMAIL : this.email,
      User.NAME : this.name ?? '',
      User.NICK_NAME : this.nickName ?? '',
      User.SEX : this.sex ?? '',
      User.AGE : this.age ?? '',
      User.IMAGE_URL : this.imageUrl ?? ''
    };
    return map;
  }

}

class AuthUser{

  final String uid;
  FirebaseUser firebaseUser;

  AuthUser({this.uid, this.firebaseUser});
}