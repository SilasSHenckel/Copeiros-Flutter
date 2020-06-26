import 'package:after_layout/after_layout.dart';
import 'package:copeiros/models/user.dart';
import 'package:flutter/material.dart';
import 'package:copeiros/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:copeiros/screens/login_wrapper.dart';
import 'package:copeiros/services/auth.dart';

class OnBoardingWrapper extends StatefulWidget {
  @override
  _OnBoardingWrapperState createState() => _OnBoardingWrapperState();
}

class _OnBoardingWrapperState extends State<OnBoardingWrapper> with AfterLayoutMixin<OnBoardingWrapper>{

  Future checkFirstSeen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seenOnBoarding = (prefs.getBool('seenOnBoarding') ?? false);

    if (_seenOnBoarding) {
      Navigator.pushReplacementNamed(context, '/after_onboarding');
//      Navigator.pushNamed(context, '/after_onboarding');
    } else {
//      await prefs.setBool('seenOnBoarding', true);
      Navigator.pushReplacementNamed(context, '/onboarding_screen');
//      Navigator.pushNamed(context, '/onboarding_screen');
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen(context);


  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}

class AfterOnBoarding extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: LoginWrapper(),
      ),
    );
  }
}