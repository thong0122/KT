import 'dart:math';

import 'package:flutter/material.dart';
import '../../model/db_helper.dart';
import '../model/task.dart';
import '../Bai1/task_add.dart';

class TaskData extends StatefulWidget {
  const TaskData({Key? key,
    }) : super(key: key);

  @override
  State<TaskData> createState() => _TaskDataState();
}

class _TaskDataState extends State<TaskData> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
    Future<List<TaskModel>> _getTasks() async {
      // thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
      return await _databaseHelper.tasks();
    }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
        future: _getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No task available"),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final itemCat = snapshot.data![index];
                return _buildTask(itemCat, context);
              },
            ),
          );
        },
      );
    }
    Widget _buildTask(TaskModel breed, BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                   color: Color.fromARGB(255, 243, 158, 31), 
                        
                ),
                
                alignment: Alignment.center,
                child: Text(
                  breed.id.toString(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      breed.day,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(breed.content),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      DatabaseHelper().deleteTask(breed.id!);
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (_) => TaskAdd(
                                isUpdate: true,
                                taskModel: breed,
                              ),
                              fullscreenDialog: true,
                            ),
                          )
                          .then((_) => setState(() {}));
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.yellow.shade800,
                  ))
            ],
          ),
        ),
      );
    }
}