import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une tâche'),
      ),
      body: const AddTodo(),
    );
  }
}

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _controller = TextEditingController();

    return Column(
      spacing: 12,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nom de la tâche',
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(todoListProvider.notifier).addTask(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}