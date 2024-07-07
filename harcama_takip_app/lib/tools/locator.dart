import 'package:get_it/get_it.dart';
import 'package:harcama_takip_app/repository/database_repository.dart';
import 'package:harcama_takip_app/service/authentication/auth_service.dart';
import 'package:harcama_takip_app/service/cloud_firestore/firestore_service.dart';

GetIt locator = GetIt.instance;


setupLocator(){
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirestoreService());

}