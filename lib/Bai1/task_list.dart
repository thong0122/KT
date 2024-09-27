import 'package:flutter/material.dart';
import 'task_add.dart';
import 'task_data.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
    int selectedIndex = 0;

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _loadWidget(int index) {
    switch (index) {
      case 0:
        return const TaskList(); // Replace with your actual TaskList widget
      case 1:
        return const Center(
          child: Text("Calendar Page"), // Placeholder for Calendar widget
        );
      case 2:
        return const Center(
          child: Text("Settings Page"), // Placeholder for Settings widget
        );
      default:
        return const TaskList();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: const Text("Task List"),
      ),
      body: Center(child: TaskData()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => const TaskAdd(),
                  fullscreenDialog: true,
                  
                ),
              )
              .then((_) => setState(() {}));
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Work",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: onItemTap,
      ),
    );
  }
}