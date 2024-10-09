import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/util/task.dart';

class SharedPref {
  // Set(save) Data
  Future<void> saveUserList(List<Task> tasks) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList("person_list", jsonStringList);
    print('kaydedildi');
    print("jsonStringList uzunluğu: ${jsonStringList.length}");
  }

  // Get(load) Data
  Future<List<Task>> getUserList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList("person_list");

    if(jsonStringList != null){
      return  await jsonStringList.map((task) => Task.fromJson(jsonDecode(task))).toList();
      print("Get user jsonstringlist length ${jsonStringList.length}");
    } else{
      return  await [];
    }
    print("Get user jsonstringlist length ${jsonStringList?.length}");
    //print('SharedPreferences tan get görev listesi yüklendi: ${tasks.length}');
  }

}