import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';

class SelectSubject extends StatelessWidget {
  final Subjects subjects;
  const SelectSubject({Key? key, required this.subjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List subjects = [
      'Engineering Mathematics III (EM3)',
      'Data Structure and Algorithms (DSA)',
      'Software Engineering (SE)',
      'Microprocessor (MP)',
      'Principles of Programming Languages (PPL)'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Class - Subject"),
        // backgroundColor: const Color(0xff6C5DDC),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Select a Subject",
                style: TextStyle(fontSize: 20),
              ),
              DropdownButton(
                hint: const Text("Subjects"),
                icon: const Icon(Icons.arrow_drop_down_outlined),
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: subjects.map((ValueItem) {
                  return DropdownMenuItem(
                    value: ValueItem,
                    child: Text(ValueItem),
                  );
                }).toList(),
                onChanged: (Object? value) {},
              ),
              // items: const <String>['Engineering Mathematics III (EM3)', 'Data Structure and Algorithms (DSA)', 'Software Engineering (SE)', 'Microprocessor (MP)', 'Principles of Programming Languages (PPL)'], onChanged: onChanged)
            ]),
      ),
    );
  }
}
