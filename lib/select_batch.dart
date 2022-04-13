import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';

class SelectBatch extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Subjects Class;
  const SelectBatch({Key? key, required this.Class}) : super(key: key);

  @override
  _SelectBatchState createState() => _SelectBatchState();
}

class _SelectBatchState extends State<SelectBatch> {
  final items = [
    'Engineering Mathematics III (EM3)',
    'Data Structure and Algorithms (DSA)',
    'Software Engineering (SE)',
    'Microprocessor (MP)',
    'Principles of Programming Languages (PPL)',
    'Data Structure and Algorithms Laboratary (DSAL)',
    'Microprocessor Laboratary (MPL)',
    'Engineering Mathermatics Tutorial (TUT)',
    'Code of Conduct (COC)'
  ];

  String? value;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Select Class - Batch")),
        body: Center(
          child: DropdownButton<String>(
            value: value,
            hint: const Text("Subjects"),
            icon: const Icon(Icons.arrow_drop_down_outlined),
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: items.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() => this.value = value),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 100.0,
          width: 70.0,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 15.0,
              // backgroundColor: Color.fromARGB(255, 134, 131, 161),
              child: const Icon(Icons.arrow_right_alt_sharp),
              onPressed: () {
                widget.Class.subject = value;
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => SelectSubject(Class: newClass),
                //     ));
              },
            ),
          ),
        ),
      );
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item),
    );
