import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';

class CompletedTodos extends ConsumerWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final completedTodos = todos.where((todo) => todo.completed).toList();

    return ListView.builder(
      itemCount: completedTodos.length,
      itemBuilder: (context, index) {
        final todo = completedTodos[index];
        return ListTile(
          title: Text(todo.todo),
          trailing: IconButton(
            onPressed: () {
              ref.read(todoListProvider.notifier).toggleCompleted(todo);
            },
            icon: Icon(
              todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
            ),
          ),
        );
      },
    );
  }
}
