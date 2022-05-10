import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/Screens/Attendance/attendance_data.dart';
import 'package:pict_mis/Screens/Attendance/checkAttendance_view.dart';
import 'package:pict_mis/Screens/Attendance/flexibleappbar.dart';
import 'package:pict_mis/Screens/Attendance/markAttendance_view.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:pict_mis/constants.dart';

// ignore: camel_case_types, must_be_immutable
class attendance extends StatelessWidget {
  final Subjects subject;
  String subjectDoc;
  attendance({Key? key, required this.subject, required this.subjectDoc})
      : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text("Attendance: May 09, 2022"),
              stretch: true,
              pinned: true,
              backgroundColor: kPrimaryColor,
              expandedHeight: 330.0,
              flexibleSpace: FlexibleSpaceBar(
                background: MyFlexibleAppbar(
                  subject: subject,
                  subjectDoc: subjectDoc,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CheckAttendance(
                              subjectDoc: subjectDoc, subject: subject)))),
                  icon: const Icon(Icons.info_outline_rounded),
                  tooltip: 'Check Attendance',
                )
              ],
            ),
            SliverFixedExtentList(
                delegate: SliverChildListDelegate([
                  StreamBuilder(
                      stream: getUsersAttendanceSnapshots(context),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if ((snapshot.data! as QuerySnapshot).docs.isEmpty) {
                          return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('No Previous data'),
                                ]),
                          );
                        }

                        return ListView.builder(
                            itemCount:
                                (snapshot.data! as QuerySnapshot).docs.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildAttendanceCard(
                                  context,
                                  (snapshot.data! as QuerySnapshot).docs[index],
                                ));
                      })
                ]),
                itemExtent: 520.00)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MarkAttendance(subjectDoc: subjectDoc)));
        },
        label: const Text('Mark Attendance'),
        icon: const Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Stream<QuerySnapshot> getUsersAttendanceSnapshots(
      BuildContext context) async* {
    final uid = user?.uid;
    // print(uid);
    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('subjects')
        .doc(subjectDoc)
        .collection('attendance')
        .snapshots();
  }

  Widget buildAttendanceCard(BuildContext context, DocumentSnapshot document) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
            elevation: 8.0,
            color: kPrimaryLightColor,
            shadowColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      document.id,
                      style: const TextStyle(
                          fontFamily: 'Poppins', fontSize: 20.0),
                    ),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_right),
                  ],
                ))),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  viewAttendance(document: document, subjectDoc: subjectDoc))),
    );
  }
}
