import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';

class PersonPageViewModel with ChangeNotifier {

  final _repository = locator<DatabaseRepository>();

  Future<UserModel> getCurrentUser()async{
    return await _repository.getCurrentUserModel();
  }
}