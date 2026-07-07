import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Testingground extends StatefulWidget {
  const Testingground({super.key});

  @override
  State<Testingground> createState() => _TestinggroundState();
}

class _TestinggroundState extends State<Testingground> {
  final _UserData = Hive.box('UserData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print(_UserData.clear());
          },
          child: Text("Nuke it"),
        ),
      ),
    );
  }
}
