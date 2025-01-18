import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data_manager/data_manager.dart';
import 'package:todo_app/data_manager/shared_prefss.dart';
import 'package:todo_app/util/task.dart';

class TaskController extends GetxController{

  DataManager dataManager = DataManager();
  SharedPref sharedPref = SharedPref();


  // List of tasks
  var tasks = <Task>[].obs;

  List<Task> completedTasks = [];

  void loadTasks() async {
    List<Task> taskList = await sharedPref.getUserList();
    tasks.assignAll(taskList);
  }

  void addTaskAndSave(List<Task> tasklist,Task task,BuildContext context){
    dataManager.addTask(task, tasklist, context);
    sharedPref.saveUserList(tasklist);
    print(task.isFavorite);
  }

  void deleteTaskAndSave(List<Task> tasklist,Task task){
    dataManager.deleteTask(tasklist, task);
    sharedPref.saveUserList(tasklist);
  }

}

