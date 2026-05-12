
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskApiService {
  static const String _baseUrl = "https://dummyjson.com";

  static Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse("$_baseUrl/todos"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List todos = data["todos"];

      final random = Random();
      final priorities = ["niski", "średni", "wysoki"];

      return todos.map((todo) {
        final priority = priorities[random.nextInt(priorities.length)];
        final days = random.nextInt(30) + 1;
        final deadline = DateTime.now()
            .add(Duration(days: days))
            .toLocal()
            .toString()
            .split(' ')[0];

        return Task(
          id: todo["id"] as int,
          title: todo["todo"] as String,
          deadline: deadline,
          done: todo["completed"] as bool,
          priority: priority,
        );
      }).toList();
    } else {
      throw Exception("Błąd pobierania danych: ${response.statusCode}");
    }
  }
}