import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ZADANIE №2
class Task {
  final String title;
  final String deadline;
  final bool done;
  final String priority;

  Task({
    required this.title,
    required this.deadline,
    required this.done,
    required this.priority,
  });
}

class MyApp extends StatelessWidget {
  final List<Task> tasks = [
    Task(
        title: "To do my home work",
        deadline: "Today",
        done: false,
        priority: "wysoki"),
    Task(
        title: "Buy Products",
        deadline: "Today",
        done: true,
        priority: "średni"),
    Task(
        title: "Go to the Gym",
        deadline: "Tomorrow",
        done: false,
        priority: "niski"),
    Task(
        title: "Learn Flutter",
        deadline: "This week",
        done: true,
        priority: "wysoki"),
  ];

  @override
  Widget build(BuildContext context) {
    int doneTasks = tasks.where((task) => task.done).length;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("TamApp"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Masz dziś ${tasks.length} zadania (${doneTasks} wykonanych)",
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 16),

              Text(
                "Dzisiejsze zadania",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: tasks
                      .map((task) => TaskCard(task: task))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  Color getPriorityColor() {
    switch (task.priority) {
      case "wysoki":
        return Colors.red;
      case "średni":
        return Colors.orange;
      case "niski":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          task.done
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: task.done ? Colors.green : Colors.grey,
        ),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("termin: ${task.deadline}"),
            Text(
              "priorytet: ${task.priority}",
              style: TextStyle(color: getPriorityColor()),
            ),
          ],
        ),
      ),
    );
  }
}