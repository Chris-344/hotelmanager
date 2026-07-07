import 'dart:io';
import 'package:flutter/material.dart';

class Occupant extends StatelessWidget {
  final List occupantsArr;
  final int index;
  const Occupant({super.key, required this.occupantsArr, required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Image.file(File(occupantsArr[index]['AadharCardFront']))],
      ),
    );
  }
}
