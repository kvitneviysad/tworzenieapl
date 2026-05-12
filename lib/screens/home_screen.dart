import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _allTasksCount = 0;
  int _doneTasksCount = 0;
  int _todoTasksCount = 0;

  void _updateCounters(List<Task> tasks) {
    setState(() {
      _allTasksCount = tasks.length;
      _doneTasksCount = tasks.where((t) => t.done).length;
      _todoTasksCount = tasks.where((t) => !t.done).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CounterChip(
                label: 'Wszystkie',
                count: _allTasksCount,
                color: Theme.of(context).colorScheme.primary,
              ),
              _CounterChip(
                label: 'Do zrobienia',
                count: _todoTasksCount,
                color: Colors.orange,
              ),
              _CounterChip(
                label: 'Wykonane',
                count: _doneTasksCount,
                color: Colors.green,
              ),
            ],
          ),
        ),
        Expanded(
          child: TaskListScreen(
            onTasksLoaded: _updateCounters,
          ),
        ),
      ],
    );
  }
}

class _CounterChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CounterChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}