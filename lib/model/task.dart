import 'dart:convert';


class TaskModel{
  final int? id;
  final String day;
  final String content;
  final String time;
  final String locate;
  final String preside;
  final String note;

  TaskModel({
  this.id,
    required this.day,
    required this.content,
    required this.time,
    required this.locate,
    required this.preside,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'content': content,
      'time':time,
      'locate':locate,
      'preside':preside,
      'note':note
    };
  }
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id']?.toInt() ?? 0,
      day: map['day'] ?? '',
      content: map['content'] ?? '',
      time: map['time'] ?? '',
      locate: map['locate'] ?? '',
      preside: map['preside'] ?? '',
      note: map['note'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() => 'Category(id: $id, day: $day, content: $content, time: $time, locate: $locate, preside: $preside, note: $note)';
}



