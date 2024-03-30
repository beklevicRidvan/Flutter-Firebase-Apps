import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';
import '../view_model/uncompletedtodo_page_view_model.dart';

class UnCompletedTodoPageView extends StatelessWidget {
  const UnCompletedTodoPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("UNCOMPLETED TODOS"),
      actions: const[
        SizedBox(width: 30,),
         Icon(Icons.hourglass_bottom_outlined),
      ],
    );
  }

  _buildBody() {
    return Consumer<UnCompletedTodoPageViewModel>(builder: (context, value, child) {
      if(value.todos.isNotEmpty){
        return ListView.builder(itemCount: value.todos.length,itemBuilder: (context, index) {
          var currentElement = value.todos[index];
          return _buildListItem(currentElement);
        },);
      }
      else{
        return const Center(child: Text("Liste boş"),);
      }
    },);
  }

  _buildListItem(TodoModel currentElement) {
    return ListTile(
      leading: const Icon(Icons.arrow_right_outlined),
      title: Text(currentElement.todoName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      trailing: const Icon(Icons.timelapse_outlined,size: 35,),
    );
  }
}
