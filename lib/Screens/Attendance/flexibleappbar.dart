import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';

class MyFlexibleAppbar extends StatefulWidget {
  final Subjects subject;
  String subjectDoc;

  MyFlexibleAppbar({Key? key, required this.subject, required this.subjectDoc})
      : super(key: key);

  @override
  State<MyFlexibleAppbar> createState() => _MyFlexibleAppbarState();
}

class _MyFlexibleAppbarState extends State<MyFlexibleAppbar> {
  final user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? fetchDoc;
  var db = FirebaseFirestore.instance;
  var count, lectureCount;
  fetchDocs() async {
    DocumentSnapshot classData = await FirebaseFirestore.instance
        .collection('class')
        .doc(widget.subject.batch)
        .get();
    if (classData.exists) {
      fetchDoc = classData.data() as Map<String, dynamic>?;
    }
    db
        .collection('user')
        .doc(user?.uid)
        .collection('subjects')
        .doc(widget.subjectDoc)
        .collection('attendance')
        .get()
        .then((snap) => {
              lectureCount = snap.size // will return the collection size
            });

    if (mounted) {
      setState(() {
        count = fetchDoc?['totalStudents'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchDocs();
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 120.0, left: 12.0),
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
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 20.0))
          ],
        ),
      ),
    );
  }
}
