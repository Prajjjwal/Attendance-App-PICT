import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:pict_mis/class.dart';
import 'package:pict_mis/components/text_field_container.dart';
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
  final user = FirebaseAuth.instance.currentUser;

  var classData = FirebaseFirestore.instance
      .collection('class')
      .doc('G-3')
      .snapshots(); //get the data
  List _attendance = [];

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
                  }),
                ),
              ])),
              const Padding(padding: EdgeInsets.only(top: 40.0)),
              Tags(
                key: _globalKey,
                itemCount: _attendance.length,
                columns: 6,
                textField: TagsTextField(
                    textStyle: TextStyle(fontSize: 14),
                    hintText: "Enter last 2 digits",
                    duplicates: false,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    inputDecoration: const InputDecoration(
                        counterText: '',
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0))),
                    onSubmitted: (string) async {
                      // fetchDoc() async {
                      // enter here the path , from where you want to fetch the doc
                      DocumentSnapshot pathData = await FirebaseFirestore
                          .instance
                          .collection('class')
                          .doc('G-3')
                          .get();

                      if (pathData.exists) {
                        Map<String, dynamic>? fetchDoc =
                            pathData.data() as Map<String, dynamic>?;

                        //Now use fetchDoc?['KEY_names'], to access the data from firestore, to perform operations , for eg
                        var name = fetchDoc?['213$string'];

                        // setState(() {});  // use only if needed
                        setState(() {
                          var tag = '213$string $name';
                          _attendance.add(Item(title: tag));
                          print(_attendance);
                        });
                      }
                    }),
                itemBuilder: (index) {
                  final Item currentItem = _attendance[index];
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
                        _attendance.removeAt(index);
                      });
                      return true;
                    })),
                  );
                },
              )

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
    );
  }
}
