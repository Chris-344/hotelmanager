import 'dart:io';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotelmanager/util/dateselector.dart';

class Myform extends StatefulWidget {
  Myform({super.key});

  @override
  State<Myform> createState() => _MyformState();
}

class _MyformState extends State<Myform> {
  final _UserData = Hive.box('UserData');
  late List<String> customerIds;

  @override
  void initState() {
    super.initState();
    customerIds = List<String>.from(_UserData.get("ids") ?? []);
  }

  File? _selectedImage1;
  File? _selectedImage2;

  TextEditingController roomno = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController checkInDate = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  TextEditingController checkOutDate = TextEditingController();

  void addEntry() async {
    bool roomExists =
        int.parse(roomno.text) > 0 || int.parse(roomno.text) <= 44;

    if (!roomExists) return;
    if (mobileno.text.length != 10) return;
    if (_selectedImage1 == null) return;
    String id = Uuid().v4();
    final FormData = {
      "roomno": roomno.text,
      "mobileno": mobileno.text,
      "checkInDate": checkInDate.text,
      "checkOutDate": checkOutDate.text,
      // "AadharCardFront": _selectedImage1.toString(),
    };

    _UserData.put(id, FormData);
    customerIds.add(id);
    _UserData.put("ids", customerIds);

    roomno.clear();
    mobileno.clear();
    checkInDate.clear();
    checkOutDate.clear();
    setState(() {
      _selectedImage1 = null;
      _selectedImage2 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Customer")),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),

              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Room no"),
                ),
                controller: roomno,
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Mobile no"),
                  border: OutlineInputBorder(),
                ),
                controller: mobileno,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Dateselector(
                inputtype: "Check in Date",
                controller: checkInDate,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Dateselector(
                inputtype: "Check out Date",
                controller: checkOutDate,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text("Aadhar Card front "),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _clickImageOfFront();
                    },
                    child: Row(
                      children: [Text("Click me "), Icon(Icons.camera_alt)],
                    ),
                  ),
                ],
              ),
            ),
            // Aadhar card front image
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text("Aadhar Card back "),
                  ),
                  ElevatedButton(
                    // onPressed: _clickImageOfFront,
                    onPressed: () {
                      _clickImageOfBack();
                    },
                    child: Row(
                      children: [Text("Click me "), Icon(Icons.camera_alt)],
                    ),
                  ),
                ],
              ),
            ),
            // Priview of aadhar card
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.red,
                    height: 150,
                    width: 130,
                    child:
                        _selectedImage1 != null
                            ? Image.file(_selectedImage1!)
                            : Text("Image Priview"),
                  ),
                  Container(
                    color: Colors.red,
                    height: 150,
                    width: 130,
                    child:
                        _selectedImage2 != null
                            ? Image.file(_selectedImage2!)
                            : Text("Image Priview"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addEntry,
        child: Icon(Icons.add),
      ),
    );
  }

  Future _clickImageOfFront() async {
    final aadharCardFront = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (aadharCardFront == null) return;
    setState(() {
      _selectedImage1 = File(aadharCardFront.path);
    });
  }

  Future _clickImageOfBack() async {
    final aadharCardBack = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (aadharCardBack == null) return;
    setState(() {
      _selectedImage2 = File(aadharCardBack.path);
    });
  }
}
