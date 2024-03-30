import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';
import '../view_model/completedtodo_page_view_model.dart';

class CompletedTodoPageView extends StatelessWidget {
  const CompletedTodoPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("COMPLETED TOODS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    );
  }

  _buildBody() {
    return Consumer<CompletedTodoPageViewModel>(builder: (context, value, child) {
      if(value.todos.isNotEmpty){
        return ListView.builder(itemCount: value.todos.length,itemBuilder: (context, index) {
          var currentElement = value.todos[index];
          return _buildListItem(currentElement);
        },);
      }
      else{
        return const Center(child: Text("Completedi list is empty"),);
      }
    },);
  }

  _buildListItem(TodoModel currentElement) {
    return ListTile(
      leading: const Icon(Icons.arrow_right_outlined),
      title: Text(currentElement.todoName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      trailing: const Icon(Icons.check_circle,size: 35,),
    );
  }
}
