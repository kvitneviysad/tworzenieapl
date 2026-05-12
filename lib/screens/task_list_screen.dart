import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_local_database.dart';
import '../services/task_sync_service.dart';
import '../widgets/filter_bar.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  final ValueChanged<List<Task>> onTasksLoaded;

  const TaskListScreen({
    super.key,
    required this.onTasksLoaded,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _tasksFuture;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tasksFuture = _loadTasks();
  }

  Future<List<Task>> _loadTasks() async {
    await TaskSyncService.loadInitialDataIfNeeded();
    return TaskLocalDatabase.getTasks();
  }

  void _reloadTasks() {
    setState(() {
      _tasksFuture = _loadTasks();
    });
  }

  Future<void> _toggleDone(Task task, bool? value) async {
    final updated = task.copyWith(done: value ?? false);
    await TaskLocalDatabase.updateTask(updated);
    _reloadTasks();
  }

  Future<void> _deleteTask(Task task) async {
    await TaskLocalDatabase.deleteTask(task.id);
    _reloadTasks();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Zadanie "${task.title}" usunięte')),
      );
    }
  }

  Future<void> _addTask() async {
    final Task? newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (newTask != null) {
      await TaskLocalDatabase.addTask(newTask);
      _reloadTasks();
    }
  }

  Future<void> _editTask(Task task) async {
    final Task? updated = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
    );
    if (updated != null) {
      await TaskLocalDatabase.updateTask(updated);
      _reloadTasks();
    }
  }

  Future<void> _confirmDeleteAll(List<Task> allTasks) async {
    if (allTasks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lista zadań jest już pusta')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Potwierdź'),
        content: const Text('Czy na pewno chcesz usunąć wszystkie zadania?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Usuń', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await TaskLocalDatabase.deleteAllTasks();
      _reloadTasks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wszystkie zadania usunięte')),
        );
      }
    }
  }

  List<Task> _applyFilter(List<Task> tasks) {
    switch (_selectedFilter) {
      case 'done':
        return tasks.where((t) => t.done).toList();
      case 'todo':
        return tasks.where((t) => !t.done).toList();
      default:
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    "Błąd: ${snapshot.error}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _reloadTasks,
                    child: const Text('Spróbuj ponownie'),
                  ),
                ],
              ),
            ),
          );
        }

        final allTasks = snapshot.data ?? [];
        final filteredTasks = _applyFilter(allTasks);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onTasksLoaded(allTasks);
        });

        return Scaffold(
          appBar: AppBar(
            title: const Text('KrakFlow'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: allTasks.isEmpty ? Colors.grey : null,
                ),
                tooltip: 'Usuń wszystkie',
                onPressed: () => _confirmDeleteAll(allTasks),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _addTask,
            tooltip: 'Dodaj zadanie',
            child: const Icon(Icons.add),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FilterBar(
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (f) => setState(() => _selectedFilter = f),
                ),
              ),
              Expanded(
                child: filteredTasks.isEmpty
                    ? const Center(child: Text('Brak zadań do wyświetlenia'))
                    : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];

                    return Dismissible(
                      key: ValueKey(task.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _deleteTask(task),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskCard(
                        title: task.title,
                        subtitle: 'termin: ${task.deadline}',
                        done: task.done,
                        priority: task.priority,
                        onChanged: (v) => _toggleDone(task, v),
                        onTap: () => _editTask(task),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}