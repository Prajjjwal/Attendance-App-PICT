import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:pict_mis/Class%20Data/select_subject.dart';

class SelectYear extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Subjects Class;
  const SelectYear({Key? key, required this.Class}) : super(key: key);

  @override
  _SelectYearState createState() => _SelectYearState();
}

class _SelectYearState extends State<SelectYear> {
  final items = ['FE', 'SE', 'TE', 'BE'];

  String? value;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text("Select Class - Year")),
      body: Center(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: const Text("Year"),
          icon: const Icon(Icons.arrow_drop_down_outlined),
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (value) => setState(() {
            this.value = value;
            isVisible = true;
          }),
          items: items.map((year) {
            return DropdownMenuItem<String>(
              child: Text(year),
              value: year,
            );
          }).toList(),
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
              child: const Icon(Icons.arrow_right_alt_sharp),
              onPressed: () {
                widget.Class.year = value;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectSubject(Class: widget.Class),
                    ));
              },
            ),
          ),
        ),
      ));
}
