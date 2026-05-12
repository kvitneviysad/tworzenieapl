
class Task {
  final int id;
  final String title;
  final String deadline;
  final String priority;
  final bool done;

  Task({
    required this.id,
    required this.title,
    required this.deadline,
    required this.priority,
    required this.done,
  });

  Task copyWith({
    int? id,
    String? title,
    String? deadline,
    String? priority,
    bool? done,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "deadline": deadline,
      "priority": priority,
      "done": done,
    };
  }

  factory Task.fromMap(Map map) {
    return Task(
      id: map["id"] as int,
      title: map["title"] as String,
      deadline: map["deadline"] as String,
      priority: map["priority"] as String,
      done: map["done"] as bool,
    );
  }
}