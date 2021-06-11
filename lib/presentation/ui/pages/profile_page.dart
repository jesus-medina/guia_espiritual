import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guia_espiritual/data/datasource/person_local_datasource.dart';
import 'package:guia_espiritual/data/datasource/person_remote_datasource.dart';
import 'package:guia_espiritual/data/person_data.dart';
import 'package:guia_espiritual/domain/repository/person_repository.dart';
import 'package:guia_espiritual/presentation/ui/person_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final PersonLocalDataSource _personLocalDataSource =
  PersonLocalDataSource(SharedPreferences.getInstance());
  final PersonRemoteDataSource _personRemoteDataSource =
  PersonRemoteDataSource(FirebaseFirestore.instance);
  final PersonRepository _personRepository = PersonRepository(_personLocalDataSource, _personRemoteDataSource);

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<DataPerson>(
        future: _personLocalDataSource.getCurrentDataPerson(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Text("");
          }
          PersonUI personUI = PersonUI.fromDomainPerson(snapshot.data);

          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    child: Text(
                      personUI.acronym,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personUI.fullName,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      ),
                      Divider(),
                      SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        leading: Icon(Icons.house),
                        title: Text(personUI.personContact.address),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(personUI.personContact.phoneNumber),
                        onTap: () {
                          _personLocalDataSource.phoneCall();
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text(personUI.personContact.email),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
}
