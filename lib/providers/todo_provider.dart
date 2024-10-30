import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/models/todo_model.dart';
import 'package:flutter_todo/services/api_service.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]) {
    fetchTodos();
  }

  final ApiService _apiService = ApiService();

  Future<void> fetchTodos() async {
    final response = await _apiService.fetchTodos();
    state = response.todos;
  }

  Future<void> add(String todo) async {
    final response = await _apiService.addTodo(todo);
    state = [...state, response];
  }

  void update(Todo todo) {
    state = state.map((element) {
      if (element.id == todo.id) {
        return todo;
      }
      return element;
    }).toList();
  }

  void toggleCompleted(Todo todo) {
    final updatedTodo = todo.copyWith(completed: !todo.completed);
    update(updatedTodo);
  }
}

final todoListProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());
