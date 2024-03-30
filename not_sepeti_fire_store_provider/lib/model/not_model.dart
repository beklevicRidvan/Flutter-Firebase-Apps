import 'package:flutter/material.dart';

class NotModel with ChangeNotifier{
  dynamic notId;
  String notTitle;
  String notContent;


  NotModel({ this.notId,required this.notTitle,required this.notContent});



  factory NotModel.fromMap(Map<String,dynamic> map,String key){
    return NotModel(notId: key, notTitle: map["notTitle"], notContent: map["notContent"]);
  }


  Map<String,dynamic> toMap(){
    return {
      "notId":notId,
      "notTitle":notTitle,
      "notContent":notContent,
    };
  }


  void guncelle(String newTitle,String newContent){
    notTitle = newTitle;
    notContent = newContent;
  }
}