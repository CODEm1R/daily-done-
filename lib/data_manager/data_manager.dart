

import 'package:flutter/material.dart';
import 'package:todo_app/util/task.dart';

class DataManager {

  // add task function
  void addTask(Task task,List<Task> tasks,BuildContext context) {
    if(task.task_name.isNotEmpty){
      tasks.add(task);
      print("*** genel task listesi uzunlugu: ${tasks.length}");
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Please enter a task name"),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.deepPurple[200],
          )
      );
    }
  }

  // delete task function
  void deleteTask(List<Task>tasks,Task task) {
    tasks.remove(task);
    print("Deleted 1 item,tasks length: ${tasks.length}");
  }

}