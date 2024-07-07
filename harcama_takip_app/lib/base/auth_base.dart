import '../model/user_model.dart';

abstract class AuthBase{
  Future<dynamic> signIn(String email,String password,UserModel userModel);
  Future<void> signOut();
  Future<dynamic> signUp(String email,String password,UserModel userModel);
}