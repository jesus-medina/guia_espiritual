import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guia_espiritual/data/datasource/user_local_datasource.dart';
import 'package:guia_espiritual/data/datasource/user_remote_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final UserLocalDataSource _userLocalDataSource =
      UserLocalDataSource(SharedPreferences.getInstance());
  final UserRemoteDataSource _userRemoteDataSource =
      UserRemoteDataSource(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) => FutureBuilder<User>(
      future: _userRemoteDataSource.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          print('User is currently signed out F!');
        } else {
          print('User is signed in! F');
          _navigateToGuiaPage();
          return Center(child: Text(""));
        }
        return StreamBuilder<User>(
            stream: _userRemoteDataSource.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data == null) {
                print('User is currently signed out S!');
              } else {
                print('User is signed in! S');
                _navigateToGuiaPage();
                return Center(child: Text(""));
              }

              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Guía 1MAS1",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Hagamos juntos la misión"),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("SOY GUÍA, PADRE O HIJO ESPIRITUAL"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("SOY NUEVO"),
                      ),
                    ],
                  ),
                ),
              );
            });
      });

  bool _hasAlreadyNavigate = false;

  _navigateToGuiaPage() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!_hasAlreadyNavigate) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      _hasAlreadyNavigate = true;
    });
  }
}
