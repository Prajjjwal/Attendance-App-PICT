import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';

import '../class.dart';

class TimePicker extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Subjects Class;

  // ignore: non_constant_identifier_names
  const TimePicker({Key? key, required this.Class}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  List _items = [];
  String? value;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _items = TimeDropDown(widget.Class);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text("Select Class - Time Slot")),
      body: Center(
        child: DropdownButton<String>(
          value: value,
          hint: const Text("Time Slot"),
          icon: const Icon(Icons.arrow_drop_down_outlined),
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          items: _items.map((batch) {
            return DropdownMenuItem<String>(
              child: Text(batch),
              value: batch,
            );
          }).toList(),
          onChanged: (value) => setState(() {
            this.value = value;
            isVisible = true;
          }),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: SizedBox(
          height: 100.0,
          width: 70.0,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 15.0,
              // backgroundColor: Color.fromARGB(255, 134, 131, 161),
              child: const Icon(Icons.done),
              onPressed: () {
                widget.Class.timeSlot = value;

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
        ),
      ));
}
