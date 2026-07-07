import 'package:flutter/material.dart';
import 'package:hotelmanager/pages/myform.dart';
import 'package:hotelmanager/pages/occupied_today.dart';
import 'package:hotelmanager/pages/testingground.dart';
import 'package:hotelmanager/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('UserData');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),

      routes: {
        '/testingground': (context) => Testingground(),
        '/occupants': (context) => Occupants(),
        '/addcustomer': (context) => Myform(),
      },
    );
  }
}
