import 'dart:convert';

import 'package:guia_espiritual/utils.dart';

class DataPerson {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String address;
  final String birthday;
  final String spiritualGuideId;

  DataPerson(this.id, this.firstName, this.lastName, this.gender, this.email,
      this.phoneNumber, this.address, this.birthday,
      {this.spiritualGuideId});

  factory DataPerson.fromMap(String id, Map<String, dynamic> map) {
    var firstName = map[FirebaseConstants.KEY_FIRST_NAME];
    var lastName = map[FirebaseConstants.KEY_LAST_NAME];
    var gender = map[FirebaseConstants.KEY_GENDER];
    var email = map[FirebaseConstants.KEY_EMAIL];
    var phoneNumber = map[FirebaseConstants.KEY_PHONE_NUMBER];
    var address = map[FirebaseConstants.KEY_ADDRESS];
    var birthday = map[FirebaseConstants.KEY_BIRTHDAY];
    var spiritualGuideId = map[FirebaseConstants.KEY_SPIRITUAL_GUIDE_ID];

    return DataPerson(
        id, firstName, lastName, gender, email, phoneNumber, address, birthday,
        spiritualGuideId: spiritualGuideId);
  }

  factory DataPerson.fromJSONString(String jsonString) {
    var json = jsonDecode(jsonString);
    var id = json[FirebaseConstants.KEY_ID];
    var firstName = json[FirebaseConstants.KEY_FIRST_NAME];
    var lastName = json[FirebaseConstants.KEY_LAST_NAME];
    var gender = json[FirebaseConstants.KEY_GENDER];
    var email = json[FirebaseConstants.KEY_EMAIL];
    var phoneNumber = json[FirebaseConstants.KEY_PHONE_NUMBER];
    var address = json[FirebaseConstants.KEY_ADDRESS];
    var birthday = json[FirebaseConstants.KEY_BIRTHDAY];
    var spiritualGuideId = json[FirebaseConstants.KEY_SPIRITUAL_GUIDE_ID];

    return DataPerson(
        id, firstName, lastName, gender, email, phoneNumber, address, birthday,
        spiritualGuideId: spiritualGuideId);
  }

  Map<String, dynamic> toMap() => {
        FirebaseConstants.KEY_ID: id,
        FirebaseConstants.KEY_FIRST_NAME: firstName,
        FirebaseConstants.KEY_LAST_NAME: lastName,
        FirebaseConstants.KEY_GENDER: gender,
        FirebaseConstants.KEY_EMAIL: email,
        FirebaseConstants.KEY_PHONE_NUMBER: phoneNumber,
        FirebaseConstants.KEY_ADDRESS: address,
        FirebaseConstants.KEY_BIRTHDAY: birthday,
        FirebaseConstants.KEY_SPIRITUAL_GUIDE_ID: spiritualGuideId,
      };

  @override
  String toString() => jsonEncode(toMap()).toString();
}
