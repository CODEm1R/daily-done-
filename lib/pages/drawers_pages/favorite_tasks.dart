import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/util/task.dart';
import 'package:todo_app/util/task_card.dart';

class FavTask extends StatefulWidget {
  const FavTask({super.key,});

  @override
  State<FavTask> createState() => _FavTaskState();
}

class _FavTaskState extends State<FavTask> {

  final TaskController _taskController = Get.find();
  List<Task> favTasks = [];
  @override
  Widget build(BuildContext context) {
    favTasks = _taskController.tasks.where((task) => task.isFavorite == true).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text("❤ Favories"),
          centerTitle: true,
        ),
        body: GetBuilder<TaskController>(
            builder: (controller){
              return ListView.builder(
                  itemCount: favTasks.length,
                  itemBuilder: (context,index){
                    return TaskCard(task: favTasks[index]);
                  }
              );
            }
        )
    );
  }
}
