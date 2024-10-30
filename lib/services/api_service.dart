import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_todo/models/todo_model.dart';

class ApiService {
  final String baseUrl = 'https://dummyjson.com/todos';

  Future<TodoResponse> fetchTodos([limit, skip]) async {
    // Valeurs par défaut pour `limit` et `skip`
    limit ??= 30;
    skip ??= 0;

    final response =
        await http.get(Uri.parse('$baseUrl?limit=$limit&skip=$skip'));

    if (response.statusCode == 200) {
      return TodoResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> addTodo(String todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      body: json.encode({'todo': todo, 'completed': false, 'userId': 1}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<Todo> updateTodo(int id, String todo, bool completed) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      body: json.encode({'todo': todo, 'completed': completed, 'userId': 1}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }
}
