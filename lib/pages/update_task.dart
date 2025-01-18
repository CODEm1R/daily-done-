import 'package:flutter/material.dart';
import 'package:todo_app/data_manager/firestore_manager.dart';
import 'package:todo_app/util/task.dart';

// MyCallBack
typedef MyCallback = void Function(Task task);

class UpdateTask extends StatefulWidget {

  Task task;

  UpdateTask({required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  final FireStoreManager _fireStoreManager = FireStoreManager();

  void updateTask (Task task) {
    setState(() {
      task.task_name = tfTaskName.text;
      task.task_description = tfTaskDescription.text;
      task.task_date = DateTime.parse(tfTaskCalendar.text);
      task.task_priority = selectedPriority! ;
    });
  }

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
              MyTextField(tfcontroller: tfTaskName, tficon: const Icon(Icons.tips_and_updates_sharp), tflabel: "${widget.task.task_name}", tffunction: (){}),

              // Input task description TextField()
              MyTextField(tfcontroller: tfTaskDescription, tficon: const Icon(Icons.description), tflabel: "${widget.task.task_description}", tffunction: (){}),

              // Input task date TextField()
              MyTextField(tfcontroller: tfTaskCalendar, tficon: const Icon(Icons.edit_calendar), tflabel: "${widget.task.task_date.toString().split(" ")[0]}", tffunction: _showDatePicker),

              // Input task priority TextField()
              MyTextField(tfcontroller: tfTaskPriority, tficon: const Icon(Icons.priority_high), tflabel: "${widget.task.task_priority.name}", tffunction: _showPriorityPicker),

              // Save and Close buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Save Button
                  TextButton(
                      onPressed: (){
                        updateTask(widget.task);
                        //_fireStoreManager.updateTask(taskId, widget.task)
                        tfTaskName.clear();
                        tfTaskDescription.clear();
                        Navigator.pop(context);
                      }, child: const Text("Update",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 17),)
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



// Global TextField() widget
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
