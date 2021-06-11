import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guia_espiritual/data/datasource/user_local_datasource.dart';
import 'package:guia_espiritual/data/datasource/user_remote_datasource.dart';
import 'package:guia_espiritual/presentation/ui/pages/profile_page.dart';
import 'package:guia_espiritual/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserLocalDataSource _userLocalDataSource =
      UserLocalDataSource(SharedPreferences.getInstance());
  final UserRemoteDataSource _userRemoteDataSource =
      UserRemoteDataSource(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primarySwatch,
              ),
              child: Text(
                'Guia 1MAS1',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListTile(
              title: Text("Perfil"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              title: Text("Cerrar sesión"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text("1"),
          ),
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: 10,
      ));
}
