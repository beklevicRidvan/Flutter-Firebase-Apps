
import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../service/firestore_service.dart';

class UnCompletedTodoPageViewModel with ChangeNotifier{
  List<TodoModel> _todos = [];

  final _service = FireStoreService();


  UnCompletedTodoPageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }



  List<TodoModel> get todos => _todos;



  void getData()async{
    _todos = await _service.getUnCompletedTodos();
    notifyListeners();
  }
}