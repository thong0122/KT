import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/db_helper.dart';
import '../model/task.dart';

class TaskAdd extends StatefulWidget {
  final bool isUpdate;
  final TaskModel? taskModel;
  const TaskAdd({super.key, this.isUpdate = false, this.taskModel});

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locateController = TextEditingController();
  final TextEditingController _presideController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String titleText = "";
  final DatabaseHelper _databaseService = DatabaseHelper();

 Future<void> _onSave() async {
  final day = _dayController.text.trim();
  final content = _contentController.text.trim();
  final time = _timeController.text.trim();
  final locate = _locateController.text.trim();
  final preside = _presideController.text.trim();
  final note = _noteController.text.trim();

  if (day.isNotEmpty && content.isNotEmpty && time.isNotEmpty) {
    try {
      print("Attempting to save task...");  // Debugging print
      await _databaseService.insertTask(
        TaskModel(day: day, content: content, time: time, locate: locate, preside: preside, note: note),
      );
      print("Task saved successfully.");  // Debugging print
      Navigator.pop(context); // Go back after saving
    } catch (e) {
      print("Error while saving task: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving task: $e')),
      );
    }
  } else {
    // Show an error or handle empty fields
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill in all required fields')),
    );
  }
}

Future<void> _onUpdate() async {
  final day = _dayController.text.trim();
  final content = _contentController.text.trim();
  final time = _timeController.text.trim();
  final locate = _locateController.text.trim();
  final preside = _presideController.text.trim();
  final note = _noteController.text.trim();

  if (widget.taskModel != null) {
    try {
      print("Attempting to update task...");  // Debugging print
      await _databaseService.updateTask(
        TaskModel(
          id: widget.taskModel!.id,
          day: day,
          content: content,
          time: time,
          locate: locate,
          preside: preside,
          note: note,
        ),
      );
      print("Task updated successfully.");  // Debugging print
      Navigator.pop(context); // Go back after updating
    } catch (e) {
      print("Error while updating task: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating task: $e')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error updating task. Task model is null.')),
    );
  }
}


  @override
  void initState() {
    super.initState();
    if (widget.taskModel != null && widget.isUpdate) {
      _dayController.text = widget.taskModel!.day;
      _contentController.text = widget.taskModel!.content;
      _timeController.text = widget.taskModel!.time;
      _locateController.text = widget.taskModel!.locate;
      _presideController.text = widget.taskModel!.preside;
      _noteController.text = widget.taskModel!.note;
    }
    titleText = widget.isUpdate ? "Update Task" : "Add New Task";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _dayController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter day',
                  prefixIcon: Icon(Icons.calendar_today)
                  
                ),
                
                readOnly: true,
                onTap: () {
                  _selectDay();
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _contentController,
                maxLines: 3, // Adjusted to a more reasonable value
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter content',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _timeController,
                maxLines: 1, // Time input likely needs only one line
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter time',
                  prefixIcon: Icon(Icons.timelapse)
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _locateController,
                maxLines: 1, // Location should also only need one line
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter location',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _presideController,
                maxLines: 1, // Preside input likely needs only one line
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter presiding person',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _noteController,
                maxLines: 3, // Notes might require a few lines
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'notes',
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 45.0,
                child: ElevatedButton(
                  onPressed: () {
                    widget.isUpdate ? _onUpdate() : _onSave();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<void> _selectDay( ) async {
    DateTime?picked= await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if(picked!= null){
    setState(() {
      _dayController.text=picked.toString().split(" ")[0];
    });
  }
}
}
