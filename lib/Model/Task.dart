class Task{

  String title ;
  String startTime;
  String endTime;
  String type;
  String isImportant;
  String status;
  String date;
  int? id;
  Task({
    this.id,
    required this.status,
  required this.type,
  required this.title,
  required this.date,
  required this.endTime,
  required this.isImportant,
  required this.startTime
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'type': type,
      'title': title,
      'date': date,
      'endTime': endTime,
      'startTime': startTime,
      'isImportant': isImportant,
    };
  }
}