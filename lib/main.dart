import 'package:flutter/material.dart';
import 'package:guia_espiritual/presentation/ui/pages/main_page.dart';

import 'utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColor.primarySwatch,
        accentColor: AppColor.accent,
      ),
      home: MainPage());
}
