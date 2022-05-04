import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pict_mis/Subjects.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final Subjects subject;
  // ignore: prefer_typing_uninitialized_variables
  MyFlexiableAppBar({Key? key, required this.subject}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? fetchDoc;
  String? count;
  fetchDocs() async {
    DocumentSnapshot classData = await FirebaseFirestore.instance
        .collection('class')
        .doc(subject.batch)
        .get();
    print(subject.batch);
    if (classData.exists) {
      fetchDoc = classData.data() as Map<String, dynamic>?;
    }
    count = fetchDoc?['totaStudents'];
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
            Text(subject.subject,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: 30.0)),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              children: <Widget>[
                Text(subject.batch,
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
            const Text('Total Lectures : 1',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 20.0))
          ],
        ),
      ),
    );
  }
}
