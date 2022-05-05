import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/constants.dart';

class viewAttendance extends StatefulWidget {
  DocumentSnapshot document;
  viewAttendance({Key? key, required this.document}) : super(key: key);

  @override
  State<viewAttendance> createState() => _viewAttendanceState();
}

class _viewAttendanceState extends State<viewAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 217, 215, 215),
        appBar: AppBar(
          elevation: 10.0,
          title: Text(widget.document.id),
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          child: Padding(
              padding: const EdgeInsets.only(top: 200.0, left: 5.0, right: 5.0),
              child: GridView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.pinkAccent),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
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
                        const Padding(padding: EdgeInsets.only(top: 80)),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blue),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
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
                        const Padding(padding: EdgeInsets.only(top: 80)),
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
                  )
                ],
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    childAspectRatio: 120.0 / 180.0),
              )),
        ));
  }
}
