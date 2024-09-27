import 'package:flutter/material.dart';
import 'package:ktdgkt/Bai1/task_list.dart'; // Ensure this path is correct

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      body: _loadWidget(selectedIndex),
    );
  }
}
