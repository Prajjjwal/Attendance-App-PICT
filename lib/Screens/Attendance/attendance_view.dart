import 'package:flutter/material.dart';
import 'package:pict_mis/Screens/Attendance/flexibleappbar.dart';
import 'package:pict_mis/Screens/Attendance/markAttendance_view.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:pict_mis/constants.dart';

// ignore: camel_case_types
class attendance extends StatelessWidget {
  final Subjects subject;
  const attendance({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text("Attendance: April 30, 2022"),
              stretch: true,
              pinned: true,
              backgroundColor: kPrimaryColor,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: MyFlexiableAppBar(
                  subject: subject,
                ),
              ),
            ),
            SliverFixedExtentList(
                delegate: SliverChildListDelegate([
                  Text(subject.subject),
                  Text(subject.subject),
                  Text(subject.subject),
                  Text(subject.subject),
                  Text(subject.subject),
                  Text(subject.subject),
                ]),
                itemExtent: 200.00)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MarkAttendance()));
        },
        label: const Text('Mark Attendance'),
        icon: const Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
