import 'package:flutter/material.dart';
import 'package:harcama_takip_app/model/user_model.dart';

import '../../repository/database_repository.dart';
import '../../tools/locator.dart';

class LoginPageViewModel with ChangeNotifier {
  late final TextEditingController _emailController;
  late final TextEditingController _pwController;

  final _repository = locator<DatabaseRepository>();

  LoginPageViewModel() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void login(BuildContext context) async {
    try{
      if (_emailController.text.isNotEmpty && _pwController.text.isNotEmpty) {
        UserModel userModel = UserModel(userEmail: _emailController.text);
        dynamic userId = await _repository.signIn(
            _emailController.text, _pwController.text, userModel);
        userModel.userId = userId;
      }
    }
    catch (e){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),),);

    }
  }

  TextEditingController get pwController => _pwController;

  TextEditingController get emailController => _emailController;
}
