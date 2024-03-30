import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../service/firestore_service.dart';

class CompletedTodoPageViewModel with ChangeNotifier{

  final _service = FireStoreService();


  List<TodoModel> _todos = [];



  CompletedTodoPageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }


  void getData()async{
    _todos =await _service.getCompletedTodos();
    notifyListeners();

  }

  List<TodoModel> get todos => _todos;
}