import '../clients/clients.dart';
import '../models/models.dart';

class TodoRepository {
  final TodoClient _client = TodoClient();

  // TodoModel 목록 가져오기
  List<TodoModel> getTodos() {
    return _client.fetchTodos();
  }

  // TodoModel 추가
  List<TodoModel> addTodo(String todoText) {
    final List<TodoModel> currentTodos = _client.fetchTodos();
    final newTodo = TodoModel(
      todo: todoText,
      createdTime: DateTime.now(),
    );
    final updatedTodos = [...currentTodos, newTodo];
    _client.saveTodos(updatedTodos);
    return updatedTodos;
  }

  // TodoModel 삭제
  List<TodoModel> deleteTodoAt(int index) {
    final List<TodoModel> currentTodos = _client.fetchTodos();
    currentTodos.removeAt(index);
    _client.saveTodos(currentTodos);
    return currentTodos;
  }

  // TodoModel 완료 상태 토글
  List<TodoModel> toggleTodoStatus(int index) {
    final List<TodoModel> currentTodos = _client.fetchTodos();
    currentTodos[index].isDone = !currentTodos[index].isDone;
    _client.saveTodos(currentTodos);
    return currentTodos;
  }
}
