import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:pict_mis/Class%20Data/select_batch.dart';
import '../class.dart';

class SelectSubject extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Subjects Class;
  const SelectSubject({Key? key, required this.Class}) : super(key: key);

  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  // final items = [
  //   'Engineering Mathematics III (EM3)',
  //   'Data Structure and Algorithms (DSA)',
  //   'Software Engineering (SE)',
  //   'Microprocessor (MP)',
  //   'Principles of Programming Languages (PPL)',
  //   'Data Structure and Algorithms Laboratary (DSAL)',
  //   'Microprocessor Laboratary (MPL)',
  //   'Engineering Mathermatics Tutorial (TUT)',
  //   'Code of Conduct (COC)'
  // ];

  List _items = [];

  // ignore: non_constant_identifier_names
  // SubjectsDropDown() {
  //   SE_even.forEach((key, value) {
  //     for (var i in value) {
  //       _items.add(i);
  //     }
  //   });
  // }

  String? value;
  @override
  void initState() {
    super.initState();
    _items = subjectsDropDown(widget.Class);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Select Class - Subject")),
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
            onChanged: (value) => setState(() => this.value = value),
            items: _items.map((subject) {
              return DropdownMenuItem<String>(
                child: Text(subject),
                value: subject,
              );
            }).toList(),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectBatch(Class: widget.Class),
                    ));
              },
            ),
          ),
        ),
      );
}

// DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem<String>(
//       value: item,
//       child: Text(item),
//     ); 



