import 'package:flutter/material.dart';
import 'package:harcama_takip_app/model/user_model.dart';

import '../../repository/database_repository.dart';
import '../../tools/locator.dart';

class RegisterPageViewModel with ChangeNotifier {

  late final TextEditingController _emailController;
  late final TextEditingController _pwController;
  late final TextEditingController _confirmController;


  final _repository = locator<DatabaseRepository>();

  RegisterPageViewModel() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _confirmController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void register(BuildContext context) async {
    try{
      if(_emailController.text.isNotEmpty && _pwController.text.isNotEmpty){
        if(_pwController.text == _confirmController.text){
          UserModel userModel = UserModel(userEmail: _emailController.text);
          dynamic userId =await _repository.signUp(_emailController.text, _pwController.text, userModel);
          userModel.userId = userId;
        }
      }
    }
    catch (e){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),),);

    }
  }

  TextEditingController get pwController => _pwController;

  TextEditingController get emailController => _emailController;

  TextEditingController get confirmController => _confirmController;
}
