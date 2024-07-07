import '../model/card_model.dart';
import '../model/user_model.dart';

abstract class DatabaseBase{
  Stream<dynamic> getCardData();
  Future<dynamic> addCard(CardModel cardModel);
  Future<void> deleteCard(CardModel cardModel);
  Future<void> updateCard(dynamic newPrice,String newPaymentName,CardModel cardModel);

  Future<UserModel> getCurrentUserModel();
}