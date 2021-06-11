import 'package:guia_espiritual/data/person_data.dart';
import 'package:guia_espiritual/domain/person.dart';

class PersonUI {
  final String id;
  final String firstName;
  final String lastName;
  final PersonGenderUI gender;
  final PersonContactUI personContact;
  final String birthday;
  final String spiritualGuideId;

  PersonUI(this.id, this.firstName, this.lastName, this.gender,
      this.personContact, this.birthday,
      {this.spiritualGuideId});

  String get fullName => "$firstName $lastName";

  String get acronym =>
      "${firstName.substring(0, 1)}${lastName.substring(0, 1)}";

  factory PersonUI.fromDomainPerson(DomainPerson domainPerson) {
    final id = domainPerson.id;
    final firstName = domainPerson.firstName;
    final lastName = domainPerson.lastName;
    PersonGenderUI gender = PersonGenderUI.NonSpecified;
    switch (domainPerson.gender) {
      case DomainPersonGender.Male:
        gender = PersonGenderUI.Male;
        break;
      case DomainPersonGender.Female:
        gender = PersonGenderUI.Female;
        break;
      case DomainPersonGender.NonSpecified:
        gender = PersonGenderUI.NonSpecified;
        break;
    }
    final email = domainPerson.personContact.email;
    final phoneNumber = domainPerson.personContact.phoneNumber;
    final address = domainPerson.personContact.address;
    final PersonContactUI personContact =
        PersonContactUI(email, phoneNumber, address);
    final birthday = domainPerson.birthday;
    final spiritualGuideId = domainPerson.spiritualGuideId;

    return PersonUI(id, firstName, lastName, gender, personContact, birthday,
        spiritualGuideId: spiritualGuideId);
  }

  Map<String, dynamic> toMap() => {
        'first name': firstName,
        'last name': lastName,
        'gender': gender == PersonGenderUI.Male ? 'male' : 'female',
        'email': personContact.email,
        'phone number': personContact.phoneNumber,
        'address': personContact.address,
        'birthday': birthday,
        'spiritual guide id': spiritualGuideId,
      };

  @override
  String toString() => fullName;
}

enum PersonGenderUI { Male, Female, NonSpecified }

class PersonContactUI {
  final String email;
  final String phoneNumber;
  final String address;

  PersonContactUI(this.email, this.phoneNumber, this.address);
}
