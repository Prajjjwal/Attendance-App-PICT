// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Subjects {
  String subject;
  String batch;
  String type;
  // String timeSlot;
  String? year;
  String acronym;

  Subjects(this.acronym, this.subject, this.batch, this.type);

  Map<String, dynamic> toJson() =>
      {'subject': subject, 'batch': batch, 'type': type, 'acronym': acronym};

  Subjects.fromSnapshot(DocumentSnapshot snapshot)
      : subject = snapshot['subject'],
        batch = snapshot['batch'],
        type = snapshot['type'],
        acronym = snapshot['acronym'];
}
