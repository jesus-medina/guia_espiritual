class DomainPerson {
  final String id;
  final String firstName;
  final String lastName;
  final DomainPersonGender gender;
  final DomainPersonContact personContact;
  final String birthday;
  final String spiritualGuideId;

  DomainPerson(this.id, this.firstName, this.lastName, this.gender,
      this.personContact, this.birthday, this.spiritualGuideId);
}

enum DomainPersonGender { Male, Female, NonSpecified }

class DomainPersonContact {
  final String email;
  final String phoneNumber;
  final String address;

  DomainPersonContact(this.email, this.phoneNumber, this.address);
}
