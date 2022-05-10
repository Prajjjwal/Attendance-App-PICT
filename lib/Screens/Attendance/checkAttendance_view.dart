import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pict_mis/class.dart';
import 'package:pict_mis/constants.dart';

import '../../Subjects.dart';

class CheckAttendance extends StatefulWidget {
  String subjectDoc;
  final Subjects subject;
  CheckAttendance({Key? key, required this.subjectDoc, required this.subject})
      : super(key: key);

  @override
  State<CheckAttendance> createState() => _CheckAttendanceState();
}

class _CheckAttendanceState extends State<CheckAttendance> {
  final user = FirebaseAuth.instance.currentUser;
  var totalLectures = 0, present = 0;
  var startRoll = 0, endRoll = 0;
  String name = '';
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    getRoll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Attendance'),
        backgroundColor: kPrimaryColor,
        elevation: 10.0,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(children: [
            Text(
              'Start Roll No. : $startRoll',
              style: const TextStyle(fontSize: 16.0),
            ),
            const Spacer(),
            Text(
              'End Roll No. : $endRoll',
              style: const TextStyle(fontSize: 16.0),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: TextFormField(
            maxLength: 5,
            cursorColor: kPrimaryColor,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                counterText: '',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 2.0)),
                labelText: 'Enter Roll number',
                labelStyle: TextStyle(color: kPrimaryColor)),
            onFieldSubmitted: (string) {
              if (int.parse(string) < startRoll ||
                  int.parse(string) > endRoll) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid Roll Number!!"),
                  backgroundColor: kPrimaryColor,
                ));
              } else {
                isVisible = true;
                getStats(string);
                getName(string);
              }
            },
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 100.0)),
        Visibility(
          visible: isVisible,
          child: CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 20.0,
            percent: present / totalLectures,
            animation: true,
            animationDuration: 1000,
            animateFromLastPercent: true,
            // arcType: ArcType.FULL,
            // arcBackgroundColor: Colors.black12,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              '${(present / totalLectures * 100).toStringAsFixed(2)} %',
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
            ),
            progressColor: (present / totalLectures <= 0.75)
                ? (present / totalLectures <= 0.5)
                    ? Colors.red
                    : Colors.yellow
                : Colors.green,

            backgroundColor: (present / totalLectures <= 0.75)
                ? (present / totalLectures <= 0.5)
                    ? Colors.red.shade100
                    : Colors.yellow.shade100
                : Colors.green.shade100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
        )
      ]),
    );
  }

  void getRoll() {
    FirebaseFirestore.instance
        .collection('class')
        .doc(widget.subject.batch)
        .get()
        .then((value) {
      setState(() {
        startRoll = value.data()!['startRoll'];
        endRoll = value.data()!['endRoll'];
      });
    });
  }

  void getName(String roll) {
    FirebaseFirestore.instance
        .collection('class')
        .doc(widget.subject.batch)
        .get()
        .then((value) {
      setState(() {
        name = value.data()![roll];
      });
    });
  }

  void getStats(String roll) {
    present = 0;
    FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .collection('subjects')
        .doc(widget.subjectDoc)
        .collection('attendance')
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((element) {
        if (element.get(roll) == 1) {
          present = present + 1;
          print(present);
        }
      });
      setState(() {
        totalLectures = snapshot.docs.length;
        print(totalLectures);
      });
    });
  }
}
