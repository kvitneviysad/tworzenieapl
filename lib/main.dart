// import 'package:flutter/material.dart';
// import 'home_screen.dart';
//
// void main() {
//   runApp(const KrakFlowApp());
// }
//
// class KrakFlowApp extends StatelessWidget {
//   const KrakFlowApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'KrakFlow',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
//         useMaterial3: true,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }



// class Task {
//   String title;
//   String deadline;
//   String priority;
//   bool done;
//
//   Task({
//     required this.title,
//     required this.deadline,
//     required this.priority,
//     this.done = false,
//   });
//
//   Task copyWith({
//     String? title,
//     String? deadline,
//     String? priority,
//     bool? done,
//   }) {
//     return Task(
//       title: title ?? this.title,
//       deadline: deadline ?? this.deadline,
//       priority: priority ?? this.priority,
//       done: done ?? this.done,
//     );
//   }
// }
//
// class TaskRepository {
//   static List<Task> tasks = [
//     Task(title: 'Buy groceries', deadline: '2025-05-10', priority: 'High'),
//     Task(title: 'Read Flutter docs', deadline: '2025-05-12', priority: 'Medium', done: true),
//     Task(title: 'Fix login bug', deadline: '2025-05-08', priority: 'High'),
//     Task(title: 'Write unit tests', deadline: '2025-05-15', priority: 'Low'),
//   ];
// }


// import 'package:flutter/material.dart';
// import 'task.dart';
//
// // Task 2: EditTaskScreen mirrors AddTaskScreen but pre-fills fields
// // with the existing task data. Returns an updated Task via Navigator.pop().
// class EditTaskScreen extends StatefulWidget {
//   final Task task;
//
//   const EditTaskScreen({super.key, required this.task});
//
//   @override
//   State<EditTaskScreen> createState() => _EditTaskScreenState();
// }
//
// class _EditTaskScreenState extends State<EditTaskScreen> {
//   late TextEditingController _titleController;
//   late TextEditingController _deadlineController;
//   late String _selectedPriority;
//
//   final List<String> _priorities = ['Low', 'Medium', 'High'];
//
//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill all fields with the existing task values.
//     _titleController = TextEditingController(text: widget.task.title);
//     _deadlineController = TextEditingController(text: widget.task.deadline);
//     _selectedPriority = widget.task.priority;
//   }
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _deadlineController.dispose();
//     super.dispose();
//   }
//
//   void _save() {
//     final String title = _titleController.text.trim();
//     final String deadline = _deadlineController.text.trim();
//
//     if (title.isEmpty || deadline.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields')),
//       );
//       return;
//     }
//
//     // Return the updated task back to the calling screen.
//     final Task updatedTask = widget.task.copyWith(
//       title: title,
//       deadline: deadline,
//       priority: _selectedPriority,
//     );
//     Navigator.pop(context, updatedTask);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Task'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: _save,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _deadlineController,
//               decoration: const InputDecoration(
//                 labelText: 'Deadline (YYYY-MM-DD)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _selectedPriority,
//               decoration: const InputDecoration(
//                 labelText: 'Priority',
//                 border: OutlineInputBorder(),
//               ),
//               items: _priorities
//                   .map((p) => DropdownMenuItem(value: p, child: Text(p)))
//                   .toList(),
//               onChanged: (value) {
//                 if (value != null) {
//                   setState(() => _selectedPriority = value);
//                 }
//               },
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _save,
//                 child: const Text('Save Changes'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
//
// // Task 4 optional extension: filter buttons extracted into a separate StatelessWidget.
// class FilterBar extends StatelessWidget {
//   final String selectedFilter;
//   final ValueChanged<String> onFilterChanged;
//
//   const FilterBar({
//     super.key,
//     required this.selectedFilter,
//     required this.onFilterChanged,
//   });
//
//   static const List<String> _filters = ['all', 'todo', 'done'];
//
//   static const Map<String, String> _labels = {
//     'all': 'All',
//     'todo': 'To Do',
//     'done': 'Done',
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: _filters.map((filter) {
//         final bool isActive = selectedFilter == filter;
//         return TextButton(
//           onPressed: () => onFilterChanged(filter),
//           style: TextButton.styleFrom(
//             // Task 4: Active filter is highlighted with primary color.
//             foregroundColor: isActive
//                 ? Theme.of(context).colorScheme.primary
//                 : Colors.grey,
//             fontWeight:
//             isActive ? FontWeight.bold : FontWeight.normal,
//           ),
//           child: Text(_labels[filter]!),
//         );
//       }).toList(),
//     );
//   }
// }






// Zad1 05.05
// import 'package:flutter/material.dart';
// import 'task.dart';
// import 'task_card.dart';
// import 'filter_bar.dart';
// import 'edit_task_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   // Task 4: Active filter key. Values: 'all', 'todo', 'done'.
//   String selectedFilter = 'all';
//
//   // Returns the task list filtered according to the selected filter.
//   List<Task> get filteredTasks {
//     if (selectedFilter == 'done') {
//       return TaskRepository.tasks.where((t) => t.done).toList();
//     } else if (selectedFilter == 'todo') {
//       return TaskRepository.tasks.where((t) => !t.done).toList();
//     }
//     return TaskRepository.tasks;
//   }
//
//   // Task 1: Remove a task and show a SnackBar with the task's name.
//   void _dismissTask(Task task) {
//     setState(() {
//       TaskRepository.tasks.remove(task);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Task "${task.title}" deleted')),
//     );
//   }
//
//   // Task 5: Show AlertDialog to confirm deleting all tasks.
//   void _confirmDeleteAll() {
//     // Task 5 optional extension: disable button and inform via SnackBar if list is empty.
//     if (TaskRepository.tasks.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Task list is already empty')),
//       );
//       return;
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirm'),
//           content: const Text('Are you sure you want to delete all tasks?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   TaskRepository.tasks.clear();
//                 });
//                 Navigator.pop(context);
//                 // Task 5: Show SnackBar after deleting all tasks.
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('All tasks deleted')),
//                 );
//               },
//               child: const Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Task> tasks = filteredTasks;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KrakFlow'),
//         actions: [
//           // Task 5: Trash icon in AppBar opens the confirmation dialog.
//           // Optional extension: icon is visually disabled when the task list is empty.
//           IconButton(
//             icon: Icon(
//               Icons.delete,
//               color: TaskRepository.tasks.isEmpty ? Colors.grey : null,
//             ),
//             onPressed: _confirmDeleteAll,
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//             child: Text(
//               'You have ${TaskRepository.tasks.length} task(s) today',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           const SizedBox(height: 4),
//           // Task 4 optional extension: FilterBar is a separate StatelessWidget.
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: FilterBar(
//               selectedFilter: selectedFilter,
//               onFilterChanged: (filter) {
//                 setState(() => selectedFilter = filter);
//               },
//             ),
//           ),
//           Expanded(
//             child: tasks.isEmpty
//                 ? const Center(child: Text('No tasks to show'))
//                 : ListView.builder(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 8, vertical: 4),
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 // Find the real index in the original list for safe replacement.
//                 final Task task = tasks[index];
//
//                 return Dismissible(
//                   // Task 1: Unique key required by Dismissible.
//                   key: ValueKey(task.title + task.deadline),
//                   // Optional extension: swipe only from right to left.
//                   direction: DismissDirection.endToStart,
//                   onDismissed: (direction) {
//                     // Task 1: Remove task and show SnackBar with task name.
//                     _dismissTask(task);
//                   },
//                   // Red delete background shown during swipe.
//                   background: Container(
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 20),
//                     color: Colors.red,
//                     child: const Icon(Icons.delete,
//                         color: Colors.white),
//                   ),
//                   child: TaskCard(
//                     title: task.title,
//                     subtitle:
//                     'deadline: ${task.deadline} | priority: ${task.priority}',
//                     done: task.done,
//                     priority: task.priority,
//                     // Task 3: Toggle done state via Checkbox.
//                     onChanged: (value) {
//                       setState(() {
//                         task.done = value!;
//                       });
//                     },
//                     // Task 2: Tap opens EditTaskScreen and updates the list.
//                     onTap: () async {
//                       final Task? updatedTask =
//                       await Navigator.push<Task>(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               EditTaskScreen(task: task),
//                         ),
//                       );
//                       if (updatedTask != null) {
//                         setState(() {
//                           // Replace the original task in the global list.
//                           final int realIndex =
//                           TaskRepository.tasks.indexOf(task);
//                           if (realIndex != -1) {
//                             TaskRepository.tasks[realIndex] =
//                                 updatedTask;
//                           }
//                         });
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// Zadanie 3
// import 'package:flutter/material.dart';
// import 'task_repository.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("KrakFlow"),
//       ),
//
//       body: ListView.builder(
//         itemCount: TaskRepository.tasks.length,
//         itemBuilder: (context, index) {
//           final task = TaskRepository.tasks[index];
//
//           return ListTile(
//             title: Text(task.title),
//             subtitle: Text("${task.deadline} | ${task.priority}"),
//             trailing: Icon(
//               task.done ? Icons.check_circle : Icons.circle_outlined,
//               color: task.done ? Colors.green : Colors.grey,
//             ),
//           );
//         },
//       ),
//
//       // FloatingActionButton + NAVIGATION
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final Task? newTask = await Navigator.push(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (context, animation, secondaryAnimation) =>
//                   AddTaskScreen(),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                 return FadeTransition(
//                   opacity: animation,
//                   child: child,
//                 );
//               },
//             ),
//           );
//
//           if (newTask != null) {
//             setState(() {
//               TaskRepository.tasks.add(newTask);
//             });
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
// class AddTaskScreen extends StatelessWidget {
//   AddTaskScreen({super.key});
//
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController deadlineController = TextEditingController();
//   final TextEditingController priorityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Nowe zadanie"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: "Tytuł",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//
//             TextField(
//               controller: deadlineController,
//               decoration: const InputDecoration(
//                 labelText: "Termin",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//
//             TextField(
//               controller: priorityController,
//               decoration: const InputDecoration(
//                 labelText: "Priorytet",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: () {
//                 final newTask = Task(
//                   title: titleController.text,
//                   deadline: deadlineController.text,
//                   done: false,
//                   priority: priorityController.text,
//                 );
//
//                 Navigator.pop(context, newTask);
//               },
//               child: const Text("Zapisz"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// ZADANIE №2
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
//
// class Task {
//   final String title;
//   final String deadline;
//   final bool done;
//   final String priority;
//
//   Task({
//     required this.title,
//     required this.deadline,
//     required this.done,
//     required this.priority,
//   });
// }
//
// class MyApp extends StatelessWidget {
//   final List<Task> tasks = [
//     Task(
//         title: "To do my home work",
//         deadline: "Today",
//         done: false,
//         priority: "wysoki"),
//     Task(
//         title: "Buy Products",
//         deadline: "Today",
//         done: true,
//         priority: "średni"),
//     Task(
//         title: "Go to the Gym",
//         deadline: "Tomorrow",
//         done: false,
//         priority: "niski"),
//     Task(
//         title: "Learn Flutter",
//         deadline: "This week",
//         done: true,
//         priority: "wysoki"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     int doneTasks = tasks.where((task) => task.done).length;
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("TamApp"),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Masz dziś ${tasks.length} zadania (${doneTasks} wykonanych)",
//                 style: TextStyle(fontSize: 18),
//               ),
//
//               SizedBox(height: 16),
//
//               Text(
//                 "Dzisiejsze zadania",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               SizedBox(height: 16),
//
//               Expanded(
//                 child: ListView(
//                   children: tasks
//                       .map((task) => TaskCard(task: task))
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TaskCard extends StatelessWidget {
//   final Task task;
//
//   const TaskCard({super.key, required this.task});
//
//   Color getPriorityColor() {
//     switch (task.priority) {
//       case "wysoki":
//         return Colors.red;
//       case "średni":
//         return Colors.orange;
//       case "niski":
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         leading: Icon(
//           task.done
//               ? Icons.check_circle
//               : Icons.radio_button_unchecked,
//           color: task.done ? Colors.green : Colors.grey,
//         ),
//         title: Text(task.title),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("termin: ${task.deadline}"),
//             Text(
//               "priorytet: ${task.priority}",
//               style: TextStyle(color: getPriorityColor()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }