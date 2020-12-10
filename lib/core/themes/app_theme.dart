import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    primaryColor: Color(0xFF3E4C5C),
    buttonColor: Color(0xFF406FA8),
    textTheme: TextTheme(
      caption: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        color: Color(0xFF3E4C5C),
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Inter',
        fontSize: 25,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        color: Colors.white,
      ),
    ));
