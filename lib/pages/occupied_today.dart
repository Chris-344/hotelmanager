import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotelmanager/pages/occupant.dart';
import 'package:hotelmanager/util/callable_number.dart';

class Occupants extends StatefulWidget {
  Occupants({super.key});

  @override
  State<Occupants> createState() => _OccupantsState();
}

class _OccupantsState extends State<Occupants> {

  final _userData = Hive.box('UserData');

  @override
  Widget build(BuildContext context) {
    List<String> _occupantIds = List<String>.from(_userData.get("ids") ?? []);
    List<Map> _occupantsArr = [];

    for (int i = 0; i < _occupantIds.length; i++) {
      final occupant = _userData.get(_occupantIds[i]);
      if (occupant != null) {
        final entry = Map.of(Map<String, dynamic>.from(occupant));
        entry['id'] = _occupantIds[i];
        _occupantsArr.add(entry);
      }
    }

    _occupantsArr.sort((a, b) {
      final aRoom = int.tryParse(a['roomno']?.toString() ?? '') ?? 0;
      final bRoom = int.tryParse(b['roomno']?.toString() ?? '') ?? 0;
      return aRoom.compareTo(bRoom);
    });

    void delete_customer(int index) {
      final idToDelete = _occupantsArr[index]['id'];
      setState(() {
        _userData.delete(idToDelete);
        _occupantIds.remove(idToDelete);
        _userData.put("ids", _occupantIds);
        _occupantsArr.removeAt(index);
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Occupied Today')),
      body: ListView.builder(
        itemCount: _occupantsArr.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Occupant(occupantsArr: _occupantsArr, index: index);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListTile(
                tileColor: Colors.blue,
                leading: Icon(Icons.perm_identity_outlined),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => delete_customer(index),
                ),
                title: Text(
                  "Room " + _occupantsArr[index]['roomno'],
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CallableNumber(
                      index: index,
                      numberToCall: _occupantsArr[index]['mobileno'] ?? '',
                    ),
                    Text(_occupantsArr[index]['checkInDate'] ?? ''),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
