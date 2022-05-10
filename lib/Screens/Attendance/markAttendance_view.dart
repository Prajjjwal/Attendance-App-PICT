import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:intl/intl.dart';
import 'package:pict_mis/Screens/Attendance/attendance_view.dart';
import 'package:pict_mis/constants.dart';

// DocumentSnapshot? snapshot;

class MarkAttendance extends StatefulWidget {
  String subjectDoc;
  MarkAttendance({Key? key, required this.subjectDoc}) : super(key: key);

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  final List _items = ['Present Students', 'Absent Students'];
  String? valueType;
  String? rollValue;
  bool isVisible = false;
  String? date;
  final dateFormat = DateFormat('dd-MM-yyyy');
  Map<String, dynamic>? fetchDoc, pathDoc;
  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  fetchDocs() async {
    DocumentSnapshot pathData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .collection('subjects')
        .doc(widget.subjectDoc)
        .get();

    if (pathData.exists) {
      pathDoc = pathData.data() as Map<String, dynamic>?;
    }

    var batch = pathDoc?['batch'];

    DocumentSnapshot classData =
        await FirebaseFirestore.instance.collection('class').doc(batch).get();

    if (classData.exists) {
      fetchDoc = classData.data() as Map<String, dynamic>?;
    }
    //Now use fetchDoc?['KEY_names'], to access the data from firestore, to perform operations , for eg
  }

  final List _attendance = [];
  final List _tags = [];

  @override
  void initState() {
    super.initState();
    fetchDocs();
  }

  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();
  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        backgroundColor: kPrimaryColor,
        elevation: 4.0,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  onPressed: () async {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030))
                        .then((value) {
                      setState(() {
                        date = dateFormat.format(value!);
                      });
                    });
                  },
                  child: const Text('Select Date')),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                (date == null) ? "Pick date!!" : "Date : $date",
                style: const TextStyle(fontSize: 15.0, fontFamily: 'Poppins'),
              ),
              const Padding(padding: EdgeInsets.only(top: 40.0)),

              Center(
                  child: Row(children: <Widget>[
                const Text('Mark selected students as ',
                    style: TextStyle(
                      fontSize: 15.0,
                    )),
                const Padding(padding: EdgeInsets.only(left: 8.0)),
                DropdownButton<String>(
                  value: valueType,
                  autofocus: true,
                  hint: const Text("Select"),
                  items: _items.map((val) {
                    return DropdownMenuItem<String>(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    valueType = value;
                    isVisible = true;
                  }),
                ),
              ])),
              const Padding(padding: EdgeInsets.only(top: 40.0)),

              Visibility(
                visible: isVisible,
                child: Row(
                  children: <Widget>[
                    Text('Starting Roll No : ${fetchDoc?['startRoll']}'),
                    const Spacer(),
                    Text('Endind Roll No : ${fetchDoc?['endRoll']}'),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40.0)),

              Visibility(
                visible: isVisible,
                child: Tags(
                  key: _globalKey,
                  itemCount: _tags.length,
                  columns: 6,
                  textField: TagsTextField(
                      textStyle: const TextStyle(fontSize: 14),
                      hintText: "Enter last 2 digits",
                      duplicates: false,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      inputDecoration: const InputDecoration(
                          counterText: '',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor, width: 2.0))),
                      onSubmitted: (string) {
                        setState(() {
                          var tag = '213$string ${fetchDoc?['213$string']}';
                          _tags.add(Item(title: tag));
                          _attendance.add(int.parse('213$string'));
                        });
                      }),
                  // }),
                  itemBuilder: (index) {
                    final Item currentItem = _tags[index];
                    return ItemTags(
                      activeColor: kPrimaryColor,
                      colorShowDuplicate: Colors.red,
                      index: index,
                      title: currentItem.title,
                      customData: currentItem.customData,
                      textStyle: const TextStyle(fontSize: 14.0),
                      combine: ItemTagsCombine.withTextBefore,
                      removeButton: ItemTagsRemoveButton(onRemoved: (() {
                        setState(() {
                          _tags.removeAt(index);
                          _attendance.removeAt(index);
                        });
                        return true;
                      })),
                    );
                  },
                ),
              ),

              // Row(children: <Widget>[
              //   const Text(
              //     '213',
              //     style: TextStyle(fontSize: 18.0),
              //   ),
              //   Expanded(
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
              //       child: TextFormField(
              //           maxLength: 2,
              //           keyboardType: TextInputType.number,
              //           cursorColor: kPrimaryColor,
              //           onFieldSubmitted: (value) => {
              //             attendance.add('213$value')
              //           },
              //           decoration: const InputDecoration(
              //             counterText: '',
              //             focusedBorder: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: kPrimaryColor, width: 2.0),
              //             ),
              //             hintText: "Enter last 2 digit",
              //           )),
              //     ),
              //   )
              // ])
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          markingAttendance();
          Navigator.pop(context);
          // Navigator.pop(context);
        },
        label: const Text('Submit Attendance'),
        icon: const Icon(Icons.done_all),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void markingAttendance() {
    var startRoll = fetchDoc?['startRoll'];
    var endRoll = fetchDoc?['endRoll'];
    var instanceOfDb = db
        .collection("user")
        .doc(user?.uid)
        .collection("subjects")
        .doc(widget.subjectDoc)
        .collection('attendance')
        .doc(date);
    // .add(widget.Class.toJson());
    if (valueType == "Present Students") {
      instanceOfDb.set({
        "presentNo": _attendance.length,
        "absentNo": fetchDoc?['totalStudents'] - _attendance.length
      });
    } else {
      instanceOfDb.set({
        'presentNo': fetchDoc?['totalStudents'] - _attendance.length,
        "absentNo": _attendance.length
      });
    }
    while (startRoll <= endRoll) {
      if (valueType == 'Present Students') {
        bool check = _attendance.contains(startRoll);
        instanceOfDb.update({
          startRoll.toString(): check ? 1 : 0,
        });
      } else {
        bool check = _attendance.contains(startRoll);
        instanceOfDb.update({
          startRoll.toString(): check ? 0 : 1,
        });
      }

      startRoll++;
    }
  }
}
