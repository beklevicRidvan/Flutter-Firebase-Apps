
import 'package:flutter/material.dart';
import 'package:not_sepeti_fire_store_provider/view_model/home_page_view_model.dart';

class AddNotePageView extends StatelessWidget {
  final HomePageViewModel viewModel;
  const AddNotePageView({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3DED2),

      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("ADD NOTE"),
      backgroundColor: Colors.cyanAccent,
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            TextField(
              controller: viewModel.titleController,
              decoration:const InputDecoration(border: OutlineInputBorder()),
      
            ),
            const SizedBox(height: 15,),
            const Text("Content",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            TextField(
              controller: viewModel.contentController,
              maxLines: 15,
              textInputAction: TextInputAction.done,
      
              decoration:const InputDecoration(border: OutlineInputBorder()),
      
      
            ),
      
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
      
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, style: ElevatedButton.styleFrom(shape:const RoundedRectangleBorder(),backgroundColor: Colors.red),child:const Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 18),)),
                ElevatedButton(onPressed: (){
                  if(viewModel.titleController.text.isNotEmpty && viewModel.contentController.text.isNotEmpty){
                    Navigator.pop(context,[viewModel.titleController.text,viewModel.contentController.text]);
                  }
                }, style: ElevatedButton.styleFrom(shape:const RoundedRectangleBorder(),backgroundColor: Colors.green),child:const Text("Add",style: TextStyle(color: Colors.white,fontSize: 18),)),
      
              ],
            ),
      
          ],
        ),
      ),
    );
  }
}
