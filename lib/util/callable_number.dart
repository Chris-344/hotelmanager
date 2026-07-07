import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

Function call_them = (
  BuildContext context,
  int index,
  String numberToCall,
) async {
  final shouldCall = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Confirm Call"),
          content: Text("Are you sure you want to call ${numberToCall}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Call"),
            ),
          ],
        ),
  );
  if (shouldCall == true) {
    await FlutterPhoneDirectCaller.callNumber(numberToCall);
  }
};

class CallableNumber extends StatefulWidget {
  final int index;
  final String numberToCall;
  const CallableNumber({
    super.key,
    required this.index,
    required this.numberToCall,
  });

  @override
  State<CallableNumber> createState() => _CallableNumberState();
}

class _CallableNumberState extends State<CallableNumber> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => call_them(context, widget.index, widget.numberToCall),
      child: Text(
        widget.numberToCall.toString(),
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
