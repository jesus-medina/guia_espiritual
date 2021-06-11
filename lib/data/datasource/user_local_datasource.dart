import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:guia_espiritual/data/person_data.dart';
import 'package:guia_espiritual/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  final Future<SharedPreferences> _sharedPreferences;

  UserLocalDataSource(this._sharedPreferences);

  Future<void> createOrUpdateSession(
      DataPerson dataPerson, UserCredential userCredential) async {
    var sharedPreferences = await _sharedPreferences;
    User user = userCredential.user;
    var idToken = await user.getIdToken();

    sharedPreferences
      ..setString(FirebaseConstants.KEY_DATA_PERSON, dataPerson.toString())
      ..setString(FirebaseConstants.KEY_UID, user.uid)
      ..setString(FirebaseConstants.KEY_REFRESH_TOKEN, user.refreshToken)
      ..setString(FirebaseConstants.KEY_ID_TOKEN, idToken);
  }

  removeSession() async {
    var sharedPreferences = await _sharedPreferences;
    sharedPreferences
      ..remove(FirebaseConstants.KEY_DATA_PERSON)
      ..remove(FirebaseConstants.KEY_UID)
      ..remove(FirebaseConstants.KEY_REFRESH_TOKEN)
      ..remove(FirebaseConstants.KEY_ID_TOKEN);
  }
}
