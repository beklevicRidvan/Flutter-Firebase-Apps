
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todo_model.dart';

class FireStoreService{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;







  Stream<List<TodoModel>> getTodosStream() {
    return _firestore
        .collection('todos') // Firestore koleksiyon adı
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TodoModel.fromMap(doc.data(),doc.id))
        .toList());
  }


  Future<List<TodoModel>> getUnCompletedTodos()async{
    var collection = await _firestore.collection("todos").where("isCompleted",isEqualTo: false).get();
    var maps = collection.docs;
    List<TodoModel> todos = [];
    return todos = maps.map((e) => TodoModel.fromMap(e.data(),e.id)).toList();
  }

  Future<List<TodoModel>> getCompletedTodos()async{
    var collection = await _firestore.collection("todos").where("isCompleted",isEqualTo: true).get();
    var maps = collection.docs;
    List<TodoModel>  todos=[];
    return todos = maps.map((e) => TodoModel.fromMap(e.data(), e.id)).toList();
  }

  Future<String> addTodo(TodoModel todoModel)async{
    var todoId =  _firestore.collection("todos").doc().id;
    await _firestore.doc("todos/$todoId").set(todoModel.toMap(todoId));
    return todoId;
  }

  Future<void> deleteTodo(TodoModel todoModel)async{
    await _firestore.doc("todos/${todoModel.todoId}").delete();
  }

  Future<void> updateTodoName(TodoModel todoModel,String newValue) async{
    await _firestore.doc("todos/${todoModel.todoId}").set({"todoName":newValue},SetOptions(merge: true));
  }

  Future<void> updateCheckBoxValue(TodoModel todoModel,bool value)async{
    await _firestore.doc("todos/${todoModel.todoId}").update({"isCompleted":value});
  }


}