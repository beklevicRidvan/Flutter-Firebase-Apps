import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';
import '../view_model/home_page_view_model.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      drawerScrimColor: Colors.blue,
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("TODO APP"),
      centerTitle: true,
      backgroundColor: Colors.blue.shade300,
    );
  }

  _buildBody() {
    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        if (value.todos.isNotEmpty) {
          return ListView.builder(
            itemCount: value.todos.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: value.todos[index],
                child: _buildListItem(context, index),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              "Todo List is Empty",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }

  _buildListItem(BuildContext context, int index) {
    HomePageViewModel viewModel =
        Provider.of<HomePageViewModel>(context, listen: false);
    return Consumer<TodoModel>(
      builder: (context, todo, child) {
        return Dismissible(
          key: Key(todo.todoId),
          onDismissed: (direction) {
            viewModel.deleteTodo(index);
          },
          background: const Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Icon(
              Icons.clear,
              size: 50,
              color: Colors.blueAccent,
            ),
          ),
          child: Card(
            margin: const EdgeInsets.all(11),

            color: Colors.blueAccent.shade100.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  title: Text(todo.todoName,style:  TextStyle(fontSize: 18,decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.red,decorationThickness: 4)),
                  leading: Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      activeColor: Colors.blueAccent,
                        value: todo.isCompleted,
                        onChanged: (bool? value) {
                          viewModel.updateCheckValue(index, todo.isCompleted);
                        }),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        viewModel.updateTodoName(context, index);
                      },
                      icon: const Icon(Icons.edit))
                  //IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ),
            ),
          ),
        );
      },
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    HomePageViewModel viewModel =
        Provider.of<HomePageViewModel>(context, listen: false);
    return FloatingActionButton(
      onPressed: () {
        viewModel.todoNameController.text = "";
        viewModel.addTodo(context);
      },
      backgroundColor: Colors.lightBlueAccent,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  _buildDrawer(BuildContext context) {
    HomePageViewModel viewModel = Provider.of<HomePageViewModel>(context,listen: false);
    return Drawer(


      child: Column(

        children: [
          const UserAccountsDrawerHeader(decoration: BoxDecoration(gradient: LinearGradient(colors: Colors.primaries,begin: Alignment.topLeft,end: Alignment.bottomRight),color: Colors.black38),accountName:  Text("RBVC"), accountEmail:  Text("rdvn.beklevic@gmail.com")),
          Row(children: [
            const Icon(Icons.arrow_forward_ios),
            InkWell(
              onTap: (){
                viewModel.goUnCompletedPage(context);
              },
              child: const Text("UNCOMPLETED Todos",style: TextStyle(color: Colors.blue,fontSize: 20),),
            ),
          ],),
          const SizedBox(height: 50,),
          Row(
            children: [
              const Icon(Icons.arrow_forward_ios),
              InkWell(
                onTap: (){
                  viewModel.goCompletedPage(context);

                },
                child: const Text("COMPLETED Todos",style: TextStyle(color: Colors.blue,fontSize: 20),),
              ),
            ],
          )


        ],
      ),
    );
  }
}
