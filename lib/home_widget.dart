import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/Screens/Login/login_screen.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:pict_mis/Class%20Data/select_year.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final newClass = Subjects();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance: Wednesday, 23 March"),
        backgroundColor: kPrimaryColor,
        elevation: 4.0,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.remove('email');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (_) => false);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: getUsersSubjectsSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildSubjectCard(context,
                        (snapshot.data! as QuerySnapshot).docs[index]));
          }),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectYear(Class: newClass),
                  ));
            },
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersSubjectsSnapshots(BuildContext context) async* {
    final uid = user?.uid;
    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('subjects')
        .snapshots();
  }

  Widget buildSubjectCard(BuildContext context, DocumentSnapshot subject) {
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
                      subject.get('acronym'),
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  ],
                )),
            // Padding(
            //     padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
            //     child: Row(
            //       children: <Widget>[
            //         Text(
            //           subject.timeSlot!,
            //           style: const TextStyle(fontSize: 15.0),
            //         )
            //       ],
            //     )),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(children: <Widget>[
                Text(subject.get('batch'),
                    style: const TextStyle(fontSize: 20.0)),
                const Spacer(),
                if (subject.get('type') == "TH") ...[
                  const Icon(Icons.book),
                ] else ...[
                  const Icon(Icons.computer_rounded)
                ],
                Text(
                  subject.get('type'),
                  style: const TextStyle(fontSize: 20.0),
                )
              ]),
            ),
          ]),
        ));
  }
}
