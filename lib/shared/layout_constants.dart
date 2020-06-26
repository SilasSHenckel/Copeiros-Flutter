import 'package:flutter/material.dart';

const String signInKey = 'SignIn';
const String registerKey = 'Register';
const String resetPasswordKey = 'ResetPassword';

const myTextInputDecoration = InputDecoration(
    fillColor: Color(0xFF6CA8F1),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF6CA8F1), width: 1.3)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.3)
    ),
);

final myBoxDecorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
        BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
        ),
    ],
);

const myTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'CM Sans Serif',
    fontSize: 22.0,
    height: 1.3,
);

const mySubtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    height: 1.2,
);

const myLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
);

const myLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.4, 0.7, 0.9],
    colors: [
        Color(0xFF3594DD),
        Color(0xFF4563DB),
        Color(0xFF5036D5),
        Color(0xFF5B16D0),
    ],
);