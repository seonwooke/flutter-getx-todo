import 'package:get_storage/get_storage.dart';

import '../models/models.dart';

class TodoClient {
  final GetStorage _storage = GetStorage();
  final String _key = 'todos';

  // 저장된 데이터를 불러오기
  List<TodoModel> fetchTodos() {
    final storedData = _storage.read<List<dynamic>>(_key) ?? [];
    return storedData.map((json) => TodoModel.fromJson(json)).toList();
  }

  // 데이터를 저장하기
  void saveTodos(List<TodoModel> todos) {
    final jsonData = todos.map((todo) => todo.toJson()).toList();
    _storage.write(_key, jsonData);
  }
}
