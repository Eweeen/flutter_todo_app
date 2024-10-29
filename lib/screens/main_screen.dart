import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text('Ma ToDo List'),
        ),
        centerTitle: true,
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add_task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return todos.isEmpty
        ? Center(
            child: Text("Aucun élément"),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(todos[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(todoListProvider.notifier).removeTask(index);
                      },
                    ),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ),
              );
            },
          );
  }
}
