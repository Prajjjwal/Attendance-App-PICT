import 'package:flutter/material.dart';
import 'package:pict_mis/Subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../class.dart';

class SelectBatch extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Subjects Class;

  const SelectBatch({Key? key, required this.Class}) : super(key: key);

  @override
  _SelectBatchState createState() => _SelectBatchState();
}

class _SelectBatchState extends State<SelectBatch> {
  List _items = [];
  String? value;
  bool isVisible = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _items = BatchDropDown(widget.Class);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text("Select Class - Batch")),
      body: Center(
        child: DropdownButton<String>(
          value: value,
          hint: const Text("Batch"),
          icon: const Icon(Icons.arrow_drop_down_outlined),
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          items: _items.map((batch) {
            return DropdownMenuItem<String>(
              child: Text(batch),
              value: batch,
            );
          }).toList(),
          onChanged: (value) => setState(() {
            this.value = value;
            isVisible = true;
          }),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: SizedBox(
          height: 100.0,
          width: 70.0,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 15.0,
              // backgroundColor: Color.fromARGB(255, 134, 131, 161),
              child: const Icon(Icons.arrow_right_alt_sharp),
              onPressed: () async {
                widget.Class.batch = value;
                if (widget.Class.year == 'SE') {
                  if (SE[widget.Class.subject] == 'TH') {
                    widget.Class.type = 'TH';
                  } else {
                    widget.Class.type = 'PR';
                  }
                }

                db.collection("subjects").add(widget.Class.toJson());

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
        ),
      ));
}
