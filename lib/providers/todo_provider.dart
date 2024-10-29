import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/models/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTask(String name) {
    state = [
      ...state,
      Todo(
        name: name,
        done: false,
      ),
    ];
  }

  void toggleTask(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(done: !state[i].done) else state[i]
    ];
  }

  void removeTask(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) ...[] else state[i]
    ];
  }
}

final todoListProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());
