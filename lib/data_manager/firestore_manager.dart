
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/util/task.dart';

const String TASK_COLLECTION_REF =  "tasks";

class FireStoreManager {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _tasksRef;

  FireStoreManager(){
    _tasksRef = _firestore.collection(TASK_COLLECTION_REF).withConverter<Task>(
        fromFirestore: (snapshots,_) => Task.fromJson(
          snapshots.data()!
        ),
        toFirestore: (task, _) => task.toJson()
    );
  }

  // Create
  void addTask(Task task){
    _tasksRef.add(task);
  }

  // Read
  Stream<List<Task>> getTasks(){
    return _tasksRef.snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return Task.fromJson(doc.data() as Map<String,dynamic>);
          }).toList();
    });
  }
  /*
  Stream<QuerySnapshot> readTasks(){
    return _tasksRef.snapshots();
  }
  */

  // Update
  void updateTask(String taskId, Task task){
    _tasksRef.doc(taskId).update(task.toJson());
  }

  // Delete
  void deleteTask(String taskId){
    _tasksRef.doc(taskId).delete();
  }

}



// Update i de kaydetmeyi unutma
//Shared Preferences kısmını kaldır