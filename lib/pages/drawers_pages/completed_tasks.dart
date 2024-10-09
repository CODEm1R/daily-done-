import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/util/task.dart';
import 'package:todo_app/util/task_card.dart';

class CompletedTask extends StatelessWidget {
  CompletedTask({super.key});

  final TaskController _taskController = Get.find();
  List<Task> compltdTasks = [];



  @override
  Widget build(BuildContext context) {
    compltdTasks = _taskController.tasks.where((task) => task.isCompleted == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("√ Completed Tasks"),
        centerTitle: true,
      ),
      body: GetBuilder<TaskController>(
        builder: (controller){
          return ListView.builder(
            itemCount: compltdTasks.length,
            itemBuilder: (context,index){
              return TaskCard(task: compltdTasks[index]);
            },
          );
        }
      ),
    );
  }
}
