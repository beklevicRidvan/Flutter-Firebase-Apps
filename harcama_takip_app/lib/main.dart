import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harcama_takip_app/firebase_options.dart';
import 'package:harcama_takip_app/providers/app_providers.dart';
import 'package:harcama_takip_app/tools/locator.dart';
import 'package:harcama_takip_app/view/auth_view/authgate_view.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: providers,
        child: const AuthGateView(),
      ),
    );
  }
}
