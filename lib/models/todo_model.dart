class TodoModel {
  final String todo;
  final DateTime createdTime;
  bool isDone; // 완료 여부

  TodoModel({
    required this.todo,
    required this.createdTime,
    this.isDone = false, // 기본값은 미완료 상태
  });

  // JSON 변환
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      todo: json['todo'],
      createdTime: DateTime.parse(json['createdTime']),
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'createdTime': createdTime.toIso8601String(),
      'isDone': isDone,
    };
  }
}
