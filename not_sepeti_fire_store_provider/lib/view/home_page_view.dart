
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/not_model.dart';
import '../view_model/home_page_view_model.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3DED2),
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title:  const Text("Not Sepeti Uygulaması",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.cyanAccent,
      centerTitle: true,
    );
  }



  _buildBody(){
    return Consumer<HomePageViewModel>(builder: (context, value, child) {
      if(value.notes.isNotEmpty){
        return ListView.builder(itemCount: value.notes.length,itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(value: value.notes[index],child: _buildListItem(context,index),);
        },);
      }
      else{
        return const Center(child: Text("Note List is Empty",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 22),),);
      }
    },);
  }

  _buildListItem(BuildContext context, int index) {
    HomePageViewModel viewModel = Provider.of<HomePageViewModel>(context,listen: false);
    return Consumer<NotModel>(builder: (context, note, child) {
      return ExpansionTile(
          title: Text(note.notTitle),
        leading: const Icon(Icons.note_outlined),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(note.notContent,style: const TextStyle(fontSize: 18),),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(onPressed: (){
                viewModel.updateNote(index, context);

              },style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(),backgroundColor: Colors.orangeAccent), child: const Text("UPDATE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ElevatedButton(onPressed: (){
                viewModel.deleteNote(index);
              },style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(),backgroundColor: Colors.red), child: const Text("DELETE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))

            ],
          ),

        ],
      );
    },);
  }

  _buildFloatingActionButton(BuildContext context) {
    HomePageViewModel viewModel = Provider.of<HomePageViewModel>(context,listen: false);

    return FloatingActionButton(onPressed: (){
      viewModel.titleController.text ="";
      viewModel.contentController.text ="";
      viewModel.addNote(context,viewModel);


    },shape: const CircleBorder(),backgroundColor: Colors.cyanAccent,child: const Icon(Icons.add,size: 30,),);
  }
}
