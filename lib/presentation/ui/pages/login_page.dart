import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guia_espiritual/data/datasource/person_local_datasource.dart';
import 'package:guia_espiritual/data/datasource/person_remote_datasource.dart';
import 'package:guia_espiritual/data/datasource/user_local_datasource.dart';
import 'package:guia_espiritual/data/datasource/user_remote_datasource.dart';
import 'package:guia_espiritual/data/person_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<StatefulWidget> {
  final PersonLocalDataSource _personLocalDataSource =
      PersonLocalDataSource(SharedPreferences.getInstance());
  final PersonRemoteDataSource _personRemoteDataSource =
      PersonRemoteDataSource(FirebaseFirestore.instance);
  final UserLocalDataSource _userLocalDataSource =
      UserLocalDataSource(SharedPreferences.getInstance());
  final UserRemoteDataSource _userRemoteDataSource =
      UserRemoteDataSource(FirebaseAuth.instance);

  final GlobalKey<FormState> _phoneGlobalKey = GlobalKey();
  final GlobalKey<FormState> _confirmationResultGlobalKey = GlobalKey();

  bool _isPhoneNumberValid = false;
  bool _isVerificationCodeValid = false;

  DataPerson _dataPerson;
  ConfirmationResult _confirmationResult;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _confirmationResult == null
                ? _phoneNumberForm()
                : _confirmationResultForm(),
          ),
        ),
      );

  List<Widget> _phoneNumberForm() => [
        Text(
          "Guía 1MAS1",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        SizedBox(
          height: 32,
        ),
        Text("Para usar la app, escribe tu número de teléfono"),
        Form(
          key: _phoneGlobalKey,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "(664) 123 4567"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Compártenos tu número de teléfono';
                      }
                      if (value.toString().length != 10) {
                        return 'Quizás faltan algunos números...';
                      }
                      return null;
                    },
                    onChanged: (phoneNumber) {
                      var beforePhoneNumberIsValidState = _isPhoneNumberValid;
                      if (_phoneGlobalKey.currentState.validate()) {
                        _isPhoneNumberValid = true;
                      } else {
                        _isPhoneNumberValid = false;
                      }
                      if (beforePhoneNumberIsValidState !=
                          _isPhoneNumberValid) {
                        setState(() {});
                      }
                    },
                    onSaved: _signInWithPhoneNumber,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed:
              _isPhoneNumberValid ? _phoneGlobalKey.currentState.save : null,
          child: Text("ESTE ES MI NÚMERO TELÉFONICO"),
        ),
      ];

  List<Widget> _confirmationResultForm() => [
        Text(
          "¿Cuál es el código que te enviamos?",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        SizedBox(
          height: 32,
        ),
        Text("Quizás tome unos minutos en llegar."),
        Form(
          key: _confirmationResultGlobalKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              decoration: InputDecoration(hintText: "123456"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "El número nos ayuda a saber que eres tú";
                }
                if (value.toString().length != 6) {
                  return 'Quizás faltan algunos números...';
                }
                return null;
              },
              onChanged: (phoneNumber) {
                var beforeVerificationCodeIsValidState =
                    _isVerificationCodeValid;
                if (_confirmationResultGlobalKey.currentState.validate()) {
                  _isVerificationCodeValid = true;
                } else {
                  _isVerificationCodeValid = false;
                }
                if (beforeVerificationCodeIsValidState !=
                    _isVerificationCodeValid) {
                  setState(() {});
                }
              },
              onSaved: _verifyCode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced)
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _isVerificationCodeValid
              ? _confirmationResultGlobalKey.currentState.save
              : null,
          child: Text("EL CÓDIGO ES CORRECTO"),
        ),
      ];

  _signInWithPhoneNumber(String phoneNumber) async {
    _dataPerson =
        await _personRemoteDataSource.findPersonByPhoneNumber(phoneNumber);
    if (_dataPerson == null)
      throw FirebaseException(plugin: "Person not found");
    _confirmationResult =
        await _userRemoteDataSource.signInWithPhoneNumber("+52$phoneNumber");
    setState(() {});
  }

  _verifyCode(String verificationCode) async {
    UserCredential userCredential =
        await _confirmationResult.confirm(verificationCode);
    _userLocalDataSource.createOrUpdateSession(_dataPerson, userCredential);
  }
}
