import 'package:flutter/material.dart';

class AppColor {
  static const MaterialAccentColor accent = MaterialAccentColor(
    accentPrimaryValue,
    <int, Color>{
      100: Color(0xFF7E57C2),
      200: Color(accentPrimaryValue),
      400: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
    },
  );
  static const int accentPrimaryValue = 0xFF673ab7;

  static const MaterialColor primarySwatch = MaterialColor(
    primaryValue,
    <int, Color>{
      50: Color(0xFFFFB74D),
      100: Color(0xFFFFA726),
      200: Color(0xFFFF9800),
      300: Color(0xFFFB8C00),
      400: Color(0xFFF57C00),
      500: Color(primaryValue),
      600: Color(0xFFE65100),
      700: Color(0xFFF4511E),
      800: Color(0xFFE64A19),
      900: Color(0xFFD84315),
    },
  );
  static const int primaryValue = 0xFFEF6C00;

  static const int thirdLevelValue = 0xFF03A9F4;
  static const int secondLevelValue = 0xFF66BB6A;
  static const int firstLevelValue = 0xFFFBC02D;

  static const Color thirdLevelColor = Color(thirdLevelValue);
  static const Color secondLevelColor = Color(secondLevelValue);
  static const Color firstLevelColor = Color(firstLevelValue);
}

class FirebaseConstants {
  static const KEY_DATA_PERSON = 'data person';
  static const KEY_ID = "id";
  static const KEY_FIRST_NAME = "first name";
  static const KEY_LAST_NAME = "last name";
  static const KEY_GENDER = "gender";
  static const KEY_EMAIL = "email";
  static const KEY_PHONE_NUMBER = "phone number";
  static const KEY_ADDRESS = "address";
  static const KEY_BIRTHDAY = "birthday";
  static const KEY_SPIRITUAL_GUIDE_ID = "spiritual guide id";
  static const KEY_UID = "uid";
  static const KEY_REFRESH_TOKEN = "refresh token";
  static const KEY_ID_TOKEN = "id token";
}