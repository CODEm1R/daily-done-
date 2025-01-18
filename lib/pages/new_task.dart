import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/data_manager/firestore_manager.dart';
import 'package:todo_app/util/task.dart';


class NewTask extends StatefulWidget {

  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  final TaskController _taskController = Get.find();
  final FireStoreManager _fireStoreManager = FireStoreManager();

  TaskPriority? selectedPriority;

  // Defining controller variables
  var tfTaskName = TextEditingController();
  var tfTaskDescription = TextEditingController();
  var tfTaskCalendar = TextEditingController();
  var tfTaskPriority = TextEditingController();
  
  // Date Picker function
  Future<void> _showDatePicker() async{
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if(picked != null){
      setState(() {
        tfTaskCalendar.text = picked.toString().split(" ")[0];
      });
    }
  }

  // Priority Picker function
  Future<void> _showPriorityPicker() async{
    TaskPriority? priority = await showModalBottomSheet<TaskPriority>(
        context: context,
        builder: (BuildContext context){
          return ListView(
            children: TaskPriority.values.map((TaskPriority prority) {
                return ListTile(
                  title: Text(prority.name),
                  onTap: (){
                    Navigator.pop(context,prority);
                  },
                );
              }).toList(),
          );
        }
    );

    if(priority != null){
      setState(() {
        selectedPriority = priority;
        tfTaskPriority.text = selectedPriority!.name;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A1CAC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF7A1CAC),
        title: const Text("New Task Screen",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Input task name TextField()
                MyTextField(tfcontroller: tfTaskName, tficon: const  Icon(Icons.tips_and_updates_sharp), tflabel: "Task Name", tffunction: (){}),

                // Input task description TextField()
                MyTextField(tfcontroller: tfTaskDescription, tficon: const Icon(Icons.description), tflabel: "Task Description", tffunction: (){}),

                // Input task date TextField()
                MyTextField(tfcontroller: tfTaskCalendar, tficon: const Icon(Icons.edit_calendar), tflabel: "Task Date", tffunction: _showDatePicker),

                // Input task priority TextField()
                MyTextField(tfcontroller: tfTaskPriority, tficon: const Icon(Icons.priority_high), tflabel: "Task Priority", tffunction: _showPriorityPicker),

                // Save and Close buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Save Button
                    TextButton(
                        onPressed: (){
                          Task newtask = Task(
                              task_name: tfTaskName.text,
                              task_description: tfTaskDescription.text,
                              task_date: DateTime.parse(tfTaskCalendar.text),
                              task_priority: selectedPriority!,
                              taskID: Task.maxID,
                              isFavorite: false,
                              isCompleted: false
                          );

                          //_taskController.addTaskAndSave(_taskController.tasks,newtask, context);
                          _fireStoreManager.addTask(newtask);
                          Task.maxID ++;
                          tfTaskName.clear();
                          tfTaskDescription.clear();
                          Navigator.of(context).pop();
                        }, child: const Text("Save",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 17),)
                    ),

                    //Close Button
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, child: const Text("Close",style: TextStyle(color: Colors.white70,fontSize: 15),)
                    ),
                  ],
                )
              ],
            ),

        ),
      ),
    );
  }
}



// Local TextField() widget
class MyTextField extends StatefulWidget {
  TextEditingController tfcontroller;
  Icon tficon;
  String tflabel;
  VoidCallback tffunction;
  MyTextField({super.key,required this.tfcontroller,required this.tficon,required this.tflabel,required this.tffunction});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: widget.tfcontroller,
        autofocus: true,
        style: const TextStyle(color: Colors.white70),
        onTap: widget.tffunction,
        decoration: InputDecoration(
            suffixIcon: widget.tficon,
            suffixIconColor: Colors.white,
            labelText: widget.tflabel,
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            )
        ),
      ),
    );
  }
}
