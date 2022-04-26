// ignore: file_names
class Subjects {
  String? subject;
  String? batch;
  String? type;
  String? timeSlot;
  String? year;

  Subjects(this.subject, this.batch, this.type);

  Map<String, dynamic> toJson() =>
      {'Subject': subject, 'Batch': batch, 'Type': type};
}
