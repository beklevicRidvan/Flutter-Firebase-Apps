import 'package:flutter/material.dart';

import '../../model/person_model.dart';

class PersonsDetailPageView extends StatelessWidget {
  final PersonModel person;
  const PersonsDetailPageView({super.key,required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("Person Detail"),
      backgroundColor: Colors.greenAccent,
    );
  }


  _buildBody(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundColor: Colors.deepOrangeAccent,radius: 50,child: Text((){
            String basHarfler = "";
            for (var kelime in person.personName.split(" ")){
              basHarfler += kelime[0];
            }
            return basHarfler;
          }().toString(),style: const TextStyle(fontSize: 40),),),
          const SizedBox(height: 15,),
          Text(person.personNumber,style: const TextStyle(fontSize: 30),),
          const SizedBox(height: 15,),
          Text(person.personName,style: const TextStyle(fontSize: 40),)
        ],
      ),
    );
  }
}
