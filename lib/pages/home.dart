import 'package:flutter/material.dart';
import 'package:hotelmanager/util/mydrawer.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Manager"),
        actions: [Icon(Icons.dark_mode_sharp), Text('     ')],
        backgroundColor: Colors.amber,
      ),
      drawer: Mydrawer(),
      body: Center(child: Text("Hello There")),
    );
  }
}
