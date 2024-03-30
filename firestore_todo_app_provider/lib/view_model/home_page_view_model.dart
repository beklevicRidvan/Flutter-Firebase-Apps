import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';
import '../service/firestore_service.dart';
import '../view/completedtodo_page_view.dart';
import '../view/uncompletedtodo_page_view.dart';
import 'completedtodo_page_view_model.dart';
import 'uncompletedtodo_page_view_model.dart';

class HomePageViewModel with ChangeNotifier {
  final _service = FireStoreService();

  late TextEditingController _todoNameController;


  List<TodoModel> _todos = [];

  Stream<List<TodoModel>>? _todoStream;

  List<TodoModel> get todos => _todos;

  HomePageViewModel() {
    _todoNameController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeTodoStream();
    });
  }

  void initializeTodoStream() async {
    _todoStream = _service.getTodosStream();
    _todoStream!.listen((todosData) {
      _todos = todosData;
      notifyListeners();
    });
  }

  void addTodo(BuildContext context) async {
    var values = await _showAddDialog(context);
    if (values != null && values.isNotEmpty) {
      String todoName = values[0];
      TodoModel todoModel = TodoModel(todoName: todoName);
      String myTodoId = await _service.addTodo(todoModel);
      todoModel.todoId = myTodoId;
      _todos.add(todoModel);
    }
  }

  void deleteTodo(int index) async {
    TodoModel todoModel = _todos[index];
    _todos.removeAt(index);
    await _service.deleteTodo(todoModel);
  }

  void updateTodoName(BuildContext context,int index)async{
    TodoModel todoModel = _todos[index];
    var values = await _showUpdateDialog(context,currentName: todoModel.todoName);
    if(values != null && values.isNotEmpty){
      String newTodoName = values[0];
      todoModel.updateTodoName(newTodoName);
      await _service.updateTodoName(todoModel, newTodoName);
    }
  }

  void updateCheckValue(int index, bool value) async {
    TodoModel todoModel = _todos[index];
    todoModel.changeCheckState();
    await _service.updateCheckBoxValue(todoModel, !value);
  }

  Future<List<String>?> _showAddDialog(BuildContext context) {
    return showDialog<List<String>?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ADD TODO"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _todoNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 40,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, [_todoNameController.text]);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.blue,
                      size: 40,
                    )),
              ],
            ),
          ],
        );
      },
    );
  }




  Future<List<String>?> _showUpdateDialog(BuildContext context,{String? currentName}) {
    TextEditingController currentNameController = TextEditingController(text: currentName);
    return showDialog<List<String>?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("UPDATE TODO"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 40,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, [currentNameController.text]);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.orange,
                      size: 40,
                    )),
              ],
            ),
          ],
        );
      },
    );
  }


  void goUnCompletedPage(BuildContext context){
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(create: (context) => UnCompletedTodoPageViewModel(),child: const UnCompletedTodoPageView(),);
    },);
    Navigator.push(context, pageRoute);
  }

  void goCompletedPage(BuildContext context){
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(create: (context) => CompletedTodoPageViewModel(),child: const CompletedTodoPageView(),);
    },);

    Navigator.push(context, pageRoute);
  }

  TextEditingController get todoNameController => _todoNameController;
}
