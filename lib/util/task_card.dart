import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/data_manager/shared_prefss.dart';
import 'package:todo_app/pages/update_task.dart';
import 'package:todo_app/util/task.dart';

class TaskCard extends StatefulWidget {
  Task task;

  TaskCard({super.key, required this.task,});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  final TaskController _taskController = Get.find();
  final SharedPref sharedPref = SharedPref();

  // Changing complete states
  void changeCompleteState() {
    setState(() {
      widget.task.isCompleted = !widget.task.isCompleted;
    });
    // Fix 1
    sharedPref.saveUserList(_taskController.tasks);
  }

  // Changing favorite states
  void changeFavState() {
    setState(() {
      widget.task.isFavorite = !widget.task.isFavorite;
    });
    // Fix 2
    sharedPref.saveUserList(_taskController.tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[200],
      child: Column(
        children: [
          GestureDetector(
            // Task Detail
            onDoubleTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(widget.task.task_name,style: const TextStyle(
                          fontSize: 30
                      )),
                      content: SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            Text(
                              widget.task.task_description,
                              style: const TextStyle(
                                fontSize: 25
                            ),),
                            const SizedBox(height: 10,),
                            Text("Date: ${widget.task.task_date.toString().split(" ")[0]}"),
                            Text("Priority: ${widget.task.task_priority.name}"),
                            Text("ID: ${widget.task.taskID}"),
                          ],
                        ),
                      ),
                      actions: [
                        //edit button
                        ElevatedButton.icon(
                            onPressed: () {
                              // edit task function/page
                              // Fix 3
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(task: widget.task)));
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit Task")),
                        // close button
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close),
                            label: const Text("Close")),
                      ],
                    );
                  });
            },
            // Task Card
            child: ListTile(
              // complete button
              leading: IconButton(
                  onPressed: () {
                    changeCompleteState();
                  },
                  icon: widget.task.isCompleted ?
                      const Icon(Icons.task_alt, color: Colors.white)
                      : const Icon(Icons.circle_outlined, color: Colors.white,)
              ),
              title: Text(
                widget.task.task_name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              subtitle: Text(
                widget.task.task_description,
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),

              // fav button and priority
              trailing: IconButton(
                  onPressed: () {
                    changeFavState();
                  },
                  icon: widget.task.isFavorite ?
                        const Icon(
                          Icons.favorite,
                          color: Colors.deepPurple,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.deepPurple,
                        )),
            ),
          )
        ],
      ),
    );
  }
}



