import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pict_mis/Subjects.dart';

class MyFlexibleAppbar extends StatefulWidget {
  final Subjects subject;
  String subjectDoc;
  MyFlexibleAppbar({
    Key? key,
    required this.subject,
    required this.subjectDoc,
  }) : super(key: key);

  @override
  State<MyFlexibleAppbar> createState() => _MyFlexibleAppbarState();
}

class _MyFlexibleAppbarState extends State<MyFlexibleAppbar> {
  final user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  var count;
  var lectureCount;
  // var totalPresent;
  double percentage = 0.0;

  void getCount() {
    db.collection('class').doc(widget.subject.batch).get().then((value) {
      setState(() {
        count = value.data()!['totalStudents'];
      });
    });
  }

  double overallAttendance() {
    // print('I am in');
    num totalPresent = 0;
    lectureCount = 0;
    db
        .collection('user')
        .doc(user?.uid)
        .collection('subjects')
        .doc(widget.subjectDoc)
        .collection('attendance')
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((element) {
        totalPresent = totalPresent + element.get('presentNo');
      });
      // print(totalPresent);
      // print(count);
      // print(lectureCount);
      setState(() {
        lectureCount = snapshot.docs.length;

        percentage = totalPresent / (count * lectureCount);
      });
    });
    return percentage;
  }

  @override
  void initState() {
    super.initState();
    getCount();
    // overallAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.subject.subject,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: 30.0)),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(widget.subject.batch,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 28.0)),
                      const Padding(padding: EdgeInsets.only(left: 50.0)),
                      Text('$count',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 25.0)),
                      const Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 25.0)),
                  Text('Total Lectures : $lectureCount',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20.0)),
                ]),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 5.0,
                    percent: overallAttendance(),
                    animation: true,
                    animationDuration: 1000,
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '${(percentage * 100).toStringAsFixed(2)} %',
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    progressColor: (percentage <= 0.75)
                        ? (percentage <= 0.5)
                            ? Colors.red
                            : Colors.yellow
                        : Colors.green,
                    backgroundColor: (percentage <= 0.75)
                        ? (percentage <= 0.5)
                            ? Colors.red.shade100
                            : Colors.yellow.shade100
                        : Colors.green.shade100,
                    footer: Text(
                      'Overall Attendance',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
