
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/task_controller.dart';

final _taskController = Get.put(TaskController());
class Task {
  String task_name;
  String task_description;
  TaskPriority task_priority;
  DateTime task_date;
  int taskID;
  static int maxID = _taskController.tasks.length +1;

  bool isFavorite;
  bool isCompleted;

  //static List<Task> favorites = [];
  //static List<Task> completedTasks = [];

  Task({
    required this.task_name,
    required this.task_description,
    required this.task_date,
    required this.task_priority,
    required this.taskID,
    required this.isFavorite,
    required this.isCompleted
  });

  factory Task.fromJson(Map<String,dynamic> json){
    return Task(
        task_name: json['task_name'],
        task_description: json['task_description'],
        task_priority: TaskPriority.values.byName(json['task_priority']),
        task_date: DateTime.parse(json['task_date']),
        taskID: json['ID'] ?? maxID,
        isFavorite: json['isFavorite'] ?? false,
        isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'task_name' : task_name,
      'task_description' : task_description,
      'task_priority' : task_priority.name,
      'task_date' : task_date.toIso8601String(),
      'ID' : taskID,
      'isFavorite' : isFavorite,
      'isCompleted' : isCompleted
    };
  }

}


enum TaskPriority {
  primary,
  secondary,
  tertiary
}

