import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'view/persons_page_view.dart';
import 'view_model/persons_page_view_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
              labelMedium: TextStyle(fontSize: 18, color: Colors.white),
              labelLarge: TextStyle(fontSize: 25, color: Colors.black),
              labelSmall: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 17)),
        ),
        home:ChangeNotifierProvider(create: (context) => PersonsPageViewModel(),child: const  PersonsPageView(),)

      /*
      ChangeNotifierProvider(create: (context) => HomePageViewModel(),child:  HomePage(),),

       */
    );
  }
}
