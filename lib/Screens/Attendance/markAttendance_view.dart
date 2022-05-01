import 'package:flutter/material.dart';
import 'package:pict_mis/class.dart';
import 'package:pict_mis/components/text_field_container.dart';
import 'package:pict_mis/constants.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({Key? key}) : super(key: key);

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  final List _items = ['Present Students', 'Absent Students'];
  String? valueType;
  String? rollValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        backgroundColor: kPrimaryColor,
        elevation: 4.0,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Row(children: <Widget>[
                const Text('Mark selected students as ',
                    style: TextStyle(
                      fontSize: 15.0,
                    )),
                const Padding(padding: EdgeInsets.only(left: 8.0)),
                DropdownButton<String>(
                  value: valueType,
                  autofocus: true,
                  hint: const Text("Select"),
                  items: _items.map((val) {
                    return DropdownMenuItem<String>(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    valueType = value;
                  }),
                ),
              ])),
              const Padding(padding: EdgeInsets.only(top: 280.0)),
              Row(children: <Widget>[
                const Text(
                  '213',
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
                    child: TextFormField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        cursorColor: kPrimaryColor,
                        onChanged: (value) => setState(() {
                              if (value.length <= 2) {
                                rollValue = value;
                              }
                            }),
                        decoration: const InputDecoration(
                          counterText: '',
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0),
                          ),
                          hintText: "Enter last 2 digit",
                        )),
                  ),
                )
              ])
            ],
          )),
    );
  }
}
