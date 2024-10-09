import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/pages/navbar_menu.dart';
import 'package:todo_app/pages/new_task.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:todo_app/util/task.dart';
import 'package:todo_app/util/task_card.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _taskController = Get.put(TaskController());

  // DateTime variables
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // list of selected day tasks
  List<Task> ondaytasks = [];
  List<Task> foundTasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskController.loadTasks();
    foundTasks = _taskController.tasks;
  }

  TextEditingController tfSearchWord = TextEditingController();
  late bool isSearch = false;

  void _runFilter(String enteredKeyWord){
    List<Task> results = [];

    if(enteredKeyWord.isEmpty){
      results = _taskController.tasks;
    }
    else{
      results = _taskController.tasks
          .where((task) => task.task_name.toLowerCase().contains(enteredKeyWord.toLowerCase()))
          .toList(); // toList() burada olmalı
    }
    setState(() {
      foundTasks = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isSearch?
      AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50,0,8,8),
              child: TextField(
                controller: tfSearchWord,
                style: const TextStyle(color: Colors.white70),
                onChanged: (value){
                  _runFilter(value);
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
                cursorColor: Colors.white70,
              ),
            ),
          ),
          IconButton(onPressed: (){
            setState(() {
              isSearch = false;
            });
            tfSearchWord.clear();
          }, icon: const Icon(Icons.close))
        ],
      )
      : AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Daily Done",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: (){
            setState(() {
              isSearch = true;
            });
          }, icon: const Icon(Icons.search)),
        ],
      ),

      drawer: const NavBarMenu(), // Drawer

      body: Center(
          child: Column(
            children: [
              // Table CALENDAR
              Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,12),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        weekendStyle: TextStyle(color: Colors.deepPurple)
                    ),
                    calendarFormat: CalendarFormat.twoWeeks,
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    selectedDayPredicate: (day){
                      return isSameDay(_selectedDay,day);
                    },
                    onDaySelected: (selectedDay,focusedDay){
                      setState(() {
                        _selectedDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                        _focusedDay = focusedDay; // Update Calendar
                        ondaytasks = _taskController.tasks.where((task) => task.task_date == _selectedDay).toList();
                        print("onDayTasks length : ${_taskController.tasks.length}");
                        isSearch = false;
                      });
                    },
                  )

              ),

              // 'Tasks' title
              isSearch?
              SizedBox(
                height: 30,
                child: Text("Tasks",style: TextStyle(color: Colors.deepPurple[200],fontSize: 20),),
              )
              : SizedBox(
                height: 30,
                child: Text("On Day Tasks",style: TextStyle(color: Colors.deepPurple[200],fontSize: 20),),
              ),

              // Tasks List
              Expanded(
                child: GetBuilder<TaskController>(
                    builder: (controller){
                      return ListView.builder(
                          itemCount: isSearch? foundTasks.length : ondaytasks.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              // Delete a Task
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                controller.deleteTaskAndSave(controller.tasks,ondaytasks[index]);
                                },
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),

                              // Task Card
                              child:TaskCard(
                                task: isSearch? foundTasks[index] : ondaytasks[index],
                              ),
                            );
                          });
                    }
                )

              ),
            ],
          )
      ),

      // Add new task fab button
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Colors.white,
              width: 3,
            )
        ),
        backgroundColor: Colors.deepPurple[200],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewTask()));
          print(_taskController.tasks.length);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
