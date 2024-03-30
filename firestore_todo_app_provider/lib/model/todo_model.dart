import 'package:flutter/material.dart';

class TodoModel with ChangeNotifier{
  dynamic todoId;
  String todoName;
  bool isCompleted;


  TodoModel({this.todoId,required this.todoName, this.isCompleted=false});

  factory TodoModel.fromMap(Map<String,dynamic> map,String key){
    return TodoModel(todoId: key,todoName: map["todoName"],isCompleted: map["isCompleted"]);
  }

  Map<String,dynamic> toMap(String key){
    return {
      "todoId":key,
      "todoName":todoName,
      "isCompleted":false,
    };
  }

  void updateTodoName(String newName){
    todoName = newName;
    notifyListeners();
  }

  void changeCheckState(){
    isCompleted = !isCompleted;
    notifyListeners();
  }

}