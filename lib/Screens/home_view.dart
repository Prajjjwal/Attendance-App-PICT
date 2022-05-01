import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/Screens/Login/login_screen.dart';
import 'package:pict_mis/Screens/attendance_view.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:pict_mis/Class%20Data/select_year.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    late Subjects newClass = Subjects('N/A', 'N/A', 'N/A', 'N/A');

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Subjects"),
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

                // setState(() {
                //   final user = FirebaseAuth.instance.currentUser;
                // });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: getUsersSubjectsSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildSubjectCard(
                      context,
                      (snapshot.data! as QuerySnapshot).docs[index],
                    ));
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
    // print(uid);
    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('subjects')
        .snapshots();
  }

  Widget buildSubjectCard(BuildContext context, DocumentSnapshot document) {
    final subject = Subjects.fromSnapshot(document);
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        subject.acronym,
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_outlined),
                        color: Colors.redAccent,
                        iconSize: 25,
                        onPressed: () async {
                          final uid = user?.uid;
                          final doc = FirebaseFirestore.instance
                              .collection('user')
                              .doc(uid)
                              .collection('subjects')
                              .doc(document.reference.id);

                          return await doc.delete();
                        },
                      )
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
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(subject.batch, style: const TextStyle(fontSize: 20.0)),
                  const Spacer(),
                  if (subject.type == "TH") ...[
                    const Icon(Icons.book),
                  ] else ...[
                    const Icon(Icons.computer_rounded)
                  ],
                  Text(
                    subject.type,
                    style: const TextStyle(fontSize: 20.0),
                  )
                ]),
              ),
            ]),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => attendance(subject: subject)));
          },
        ));
  }

  // Future deleteTrip(context, Subjects subject) async {
  //   final uid = user?.uid;
  //   final doc = FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(uid)
  //       .collection('subjects')
  //       .doc(subject.documentId);
  // }
}
