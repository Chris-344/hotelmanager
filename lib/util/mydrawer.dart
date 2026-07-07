import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueAccent,
      width: 180,
      child: ListView(
        children: [
          ListTile(
            title: Text("Add Customer"),
            onTap: () {
              Navigator.pushNamed(context, '/addcustomer');
            },
          ),
          ListTile(
            title: Text("Occupants"),
            onTap: () {
              Navigator.pushNamed(context, '/occupants');
            },
          ),
          ListTile(
            title: Text("Testing ground"),
            onTap: () {
              Navigator.pushNamed(context, '/testingground');
            },
          ),
        ],
      ),
    );
  }
}
