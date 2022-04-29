// ignore: file_names
class Subjects {
  String? subject;
  String? batch;
  String? type;
  String? timeSlot;
  String? year;
  String? acronym;

  Map<String, dynamic> toJson() =>
      {'subject': subject, 'batch': batch, 'type': type, 'acronym': acronym};
}
