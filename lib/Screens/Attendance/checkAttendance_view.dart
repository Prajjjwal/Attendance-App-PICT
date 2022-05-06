import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pict_mis/class.dart';
import 'package:pict_mis/constants.dart';

class CheckAttendance extends StatefulWidget {
  String subjectDoc;
  CheckAttendance({Key? key, required this.subjectDoc}) : super(key: key);

  @override
  State<CheckAttendance> createState() => _CheckAttendanceState();
}

class _CheckAttendanceState extends State<CheckAttendance> {
  final user = FirebaseAuth.instance.currentUser;
  var totalLectures = 0, present = 0;
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
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
              isVisible = true;
              getStats(string);
            },
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 180.0)),
        Center(
          child: Visibility(
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
              circularStrokeCap: CircularStrokeCap.butt,
              center: Text(
                '${(present / totalLectures * 100).toStringAsFixed(2)} %',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              progressColor: (present / totalLectures <= 0.75)
                  ? (present / totalLectures <= 0.5)
                      ? Colors.red
                      : Colors.yellow
                  : Colors.green,
            ),
          ),
        )
      ]),
    );
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
        }
      });
      setState(() {
        totalLectures = snapshot.docs.length;
      });
    });
  }
}
