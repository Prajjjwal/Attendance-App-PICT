import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/constants.dart';

class viewAttendance extends StatefulWidget {
  DocumentSnapshot document;
  String subjectDoc;

  viewAttendance({Key? key, required this.document, required this.subjectDoc})
      : super(key: key);

  @override
  State<viewAttendance> createState() => _viewAttendanceState();
}

class _viewAttendanceState extends State<viewAttendance> {
  bool isPresentFlipped = true, isAbsentFlipped = true;
  final user = FirebaseAuth.instance.currentUser;

  List present = [], absent = [];
  var db = FirebaseFirestore.instance;
  var batchDb = FirebaseFirestore.instance;

  void getAttendance() async {
    final batchDocRef = await db
        .collection('user')
        .doc(user?.uid)
        .collection('subjects')
        .doc(widget.subjectDoc)
        .get();
    var batchDoc = batchDocRef.data();
    var batch = batchDoc?['batch'];
    final docRef = await db.collection('class').doc(batch).get();
    var fetchDoc = docRef.data();
    var startRoll = fetchDoc?['startRoll'];
    var endRoll = fetchDoc?['endRoll'];
    while (startRoll <= endRoll) {
      if (widget.document.get('$startRoll') == 1) {
        present.add('$startRoll ${fetchDoc?['$startRoll']}');
      } else {
        absent.add('$startRoll ${fetchDoc?['$startRoll']}');
      }
      startRoll++;
    }
  }

  @override
  void initState() {
    super.initState();
    getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          title: Text(widget.document.id),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 250.0, left: 5.0, right: 5.0),
            child: Row(children: [
              isPresentFlipped ? presentOverview() : presentDetailed(),
              const Padding(padding: EdgeInsets.all(10.0)),
              isAbsentFlipped ? absentOverview() : absentDetailed(),
            ])));
  }

  Widget presentOverview() {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 250.0,
        width: 180.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.blue),
        child: InkWell(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const Text(
                'Total Present',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 25.0),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Text(
                widget.document.get('presentNo').toString(),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 120.0),
              )
            ],
          ),
          onTap: () => setState(() {
            isPresentFlipped = false;
          }),
        ),
      ),
    );
  }

  Widget presentDetailed() {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // padding: const EdgeInsets.only(left: 10.0),
        height: 350.0,
        width: 350.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.blue),
        child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: present
                  .map((studentData) => Text(
                        '$studentData',
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      ))
                  .toList(),
            ),
            onTap: () => setState(() {
                  isPresentFlipped = true;
                })),
      ),
    );
  }

  Widget absentOverview() {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 250.0,
        width: 180.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.pinkAccent),
        child: InkWell(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const Text(
                'Total Absent',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 25.0),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Text(
                widget.document.get('absentNo').toString(),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 120.0),
              )
            ],
          ),
          onTap: () => setState(() {
            isAbsentFlipped = false;
          }),
        ),
      ),
    );
  }

  Widget absentDetailed() {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // padding: const EdgeInsets.only(left: 20.0),
        height: 350.0,
        width: 350.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.pinkAccent),
        child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: absent
                  .map((studentData) => Text(
                        '$studentData',
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      ))
                  .toList(),
            ),
            onTap: () => setState(() {
                  isAbsentFlipped = true;
                })),
      ),
    );
  }
}
