
import 'package:flutter/material.dart';

class PersonModel with ChangeNotifier{
  String personId;
  String personName;
  String personNumber;


  PersonModel({required this.personId,required this.personName,required this.personNumber});



  factory PersonModel.fromMap(Map<String,dynamic> map,String key){
    return PersonModel(personId: key, personName: map["personName"], personNumber: map["personNumber"]);
  }


  Map<String,dynamic> toMap(){
    return {
      "personId":personId,
      "personName":personName,
      "personNumber":personNumber
    };
  }

  void update(String nPersonName,String nPersonNumber){
    personName = nPersonName;
    personNumber = nPersonNumber;
    notifyListeners();
  }

}