import 'package:copeiros/models/user.dart';
import 'package:copeiros/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user
  AuthUser _userFromFirebaseUser(FirebaseUser user){
    saveEmailTemp(user);
    return user != null ? AuthUser(uid: user.uid, firebaseUser: user) : null;
  }

  //auth change user stream
  Stream<AuthUser> get user{
    return _auth.onAuthStateChanged
//        .map((FirebaseUser user) => _userFromFirebaseUser(user));
          .map(_userFromFirebaseUser);
  }



  //sign with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      if(firebaseUser != null) {
        firebaseUser.sendEmailVerification();
        await UserService().updateUserData(User(uid : firebaseUser.uid, email : firebaseUser.email, name: '', nickName: '', sex: '', age: ''));
      }
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
      try{
        return await _auth.signOut();
      }catch(e){
        print(e.toString());
        return null;
      }
  }

  //reset password
  Future sendResetPasswordEmail(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future saveEmailTemp(FirebaseUser user) async {
    if(user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', user.email);
    }
  }

}