import 'package:flutter/material.dart';

import '../model/card_model.dart';
import '../model/user_model.dart';
import '../repository/database_repository.dart';
import '../tools/helper.dart';
import '../tools/locator.dart';

class ExpansesPageViewModel with ChangeNotifier {
  late final TextEditingController _paymentNameController;
  late final TextEditingController _priceController;

  final _repository = locator<DatabaseRepository>();

  String _secilenBanka = "Ziraat Bankası";

  var uniqueBankalar = AppHelper.turkBankalari.toSet().toList();

  String get secilenBanka => _secilenBanka;

  set secilenBanka(String value) {
    _secilenBanka = value;
    notifyListeners();
  }

  ExpansesPageViewModel() {
    _paymentNameController = TextEditingController();
    _priceController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Stream<List<CardModel>> getData() {
    return _repository.getCardData();
  }

  void delete(CardModel cardModel) async {
    await _repository.deleteCard(cardModel);
  }

  void addCard() async {
    if (_paymentNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      CardModel cardModel = CardModel(
          cardName: secilenBanka,
          paymentName: _paymentNameController.text,
          price: paymentNameController.text.contains(".")? double.parse(_priceController.text):int.parse(_priceController.text));
      var cardId = await _repository.addCard(cardModel);
      cardModel.cardId = cardId;
      secilenBanka = "Ziraat Bankası";
      _paymentNameController.clear();
      _priceController.clear();
    }
  }


  void logOut() async {
    await _repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceController.dispose();
    _paymentNameController.dispose();
    super.dispose();
  }

  void updateList() {}

  Future<UserModel> getCurrentUserModel() async {
    return await _repository.getCurrentUserModel();
  }

  TextEditingController get priceController => _priceController;

  TextEditingController get paymentNameController => _paymentNameController;
}
