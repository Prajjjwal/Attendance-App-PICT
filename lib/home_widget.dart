import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';
import 'Subjects.dart';
import 'package:pict_mis/select_subject.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Subjects> subjectsList = [
    Subjects("MP", "SE-3", "TH", "09:00am - 10:00am"),
    Subjects("DSAL", "H4", "PR", "11:15am - 01:15pm"),
    Subjects("PPL", "SE-1", "TH", "02:00pm - 03:00pm")
  ];

  @override
  Widget build(BuildContext context) {
    final newClass = new Subjects(null, null, null, null);
    ;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance: Wednesday, 23 March"),
        // backgroundColor: const Color(0xff6C5DDC),
      ),
      body: ListView.builder(
          itemCount: subjectsList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildSubjectCard(context, index)),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0.0,
            // backgroundColor: Color.fromARGB(255, 134, 131, 161),
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectSubject(Class: newClass),
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget buildSubjectCard(BuildContext context, int index) {
    final subject = subjectsList[index];
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      subject.subject!,
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      subject.timeSlot!,
                      style: const TextStyle(fontSize: 15.0),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(children: <Widget>[
                Text(subject.batch!, style: const TextStyle(fontSize: 20.0)),
                const Spacer(),
                if (subject.type == "TH") ...[
                  const Icon(Icons.book),
                ] else ...[
                  const Icon(Icons.computer_rounded)
                ],
                Text(
                  subject.type!,
                  style: const TextStyle(fontSize: 20.0),
                )
              ]),
            ),
          ]),
        ));
  }
}
