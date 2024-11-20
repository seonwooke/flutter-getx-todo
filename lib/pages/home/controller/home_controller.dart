import 'package:get/get.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

class HomeController extends GetxController {
  final TodoRepository _repository = TodoRepository();
  final todos = <TodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void loadTodos() {
    todos.assignAll(_repository.getTodos());
  }

  void addTodo(String todoText) {
    todos.assignAll(_repository.addTodo(todoText));
  }

  void removeTodoAt(int index) {
    todos.assignAll(_repository.deleteTodoAt(index));
  }

  void toggleTodoStatus(int index) {
    todos.assignAll(_repository.toggleTodoStatus(index));
  }
}
