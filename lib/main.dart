import 'package:copeiros/screens/onboarding/onboarding.dart';
import 'package:copeiros/screens/onboarding/onboarding_wrapper.dart';
import 'package:copeiros/shared/layout_constants.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(new MaterialApp(
    initialRoute: '/splash_screen',
    routes: {
      '/splash_screen' : (context) => Splash(),
      '/onboarding_screen' : (context) => OnboardingScreen(),
      '/after_onboarding' : (context) => AfterOnBoarding()
    },
  ));
}


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 6,
        title: new Text('COPEIROS',
          style: new TextStyle(
              color: Colors.white,
              letterSpacing: 10.5,
              fontWeight: FontWeight.w200,
              fontFamily: 'OpenSans',
              fontSize: 23.0
          ),),
        image: new Image.asset('assets/images/loading.gif'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.black,
        navigateAfterSeconds: new OnBoardingWrapper(),
//        gradientBackground: myLinearGradient
    );
  }
}
