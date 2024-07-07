import 'package:flutter/material.dart';
import 'package:harcama_takip_app/tools/helper.dart';
import 'package:provider/provider.dart';

import '../view_model/person_page_view_model.dart';

class PersonPageView extends StatelessWidget {
  const PersonPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FutureBuilder(
              future: Provider.of<PersonPageViewModel>(context, listen: false).getCurrentUser(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                }
                else {
                  var user = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email),
                            SizedBox(width: context.getDeviceHeight()*0.01,),

                            Text(user.userEmail)
                          ],),
                      )  ,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.person_outline),
                            SizedBox(width: context.getDeviceHeight()*0.01,),
                            Text(user.userId)
                          ],),
                      )
                    ],
                  );
                }
              },),
          ),
        )
      ],
    );
  }
}
