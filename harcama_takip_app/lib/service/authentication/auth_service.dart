import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcama_takip_app/model/user_model.dart';
import 'package:harcama_takip_app/service/authbase_base_service.dart';

class AuthService extends AuthBaseBaseService{
  
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  
  
  @override
  Future signIn(String email,String password,UserModel userModel) async{
   try{
     UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);



     return await _firestore.collection("humans").doc(user.user!.uid).set(userModel.toMap(key: user.user!.uid));

   }
   catch (e){
     throw Exception(e.toString());
   }
  }

  @override
  Future<void> signOut() async{
   await _auth.signOut();
  }

  @override
  Future signUp(String email, String password, UserModel userModel)async {
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("humans").doc(user.user!.uid).set(userModel.toMap(key: user.user!.uid));
    }
    catch (e){
      throw Exception(e.toString());
    }
  }
  
}