import 'package:harcama_takip_app/base/auth_base.dart';
import 'package:harcama_takip_app/base/database_base.dart';
import 'package:harcama_takip_app/model/card_model.dart';
import 'package:harcama_takip_app/model/user_model.dart';
import 'package:harcama_takip_app/service/authentication/auth_service.dart';
import 'package:harcama_takip_app/service/cloud_firestore/firestore_service.dart';

import '../tools/locator.dart';

class DatabaseRepository implements AuthBase,DatabaseBase{

  final _service = locator<FirestoreService>();
  final _authService = locator<AuthService>();


  @override
  Future addCard(CardModel cardModel) async{
    return await _service.addCard(cardModel);
  }

  @override
  Future<void> deleteCard(CardModel cardModel) async{
    await _service.deleteCard(cardModel);
  }

  @override
  Stream<List<CardModel>> getCardData() {
    return  _service.getCardData();
  }

  @override
  Future signIn(String email,String password,UserModel userModel) async{
   return await _authService.signIn(email,password,userModel);
  }

  @override
  Future<void> signOut()async {
    await _authService.signOut();
  }

  @override
  Future signUp(String email, String password, UserModel userModel) async{
    await _authService.signUp(email, password, userModel);
  }

  @override
  Future<void> updateCard(dynamic newPrice, String newPaymentName,CardModel cardModel)async {
    await _service.updateCard( newPaymentName,newPrice,cardModel);
  }

  @override
  Future<UserModel> getCurrentUserModel() async{
   return await _service.getCurrentUserModel();
  }

}