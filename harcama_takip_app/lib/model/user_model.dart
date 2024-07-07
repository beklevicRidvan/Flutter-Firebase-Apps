class UserModel{
  dynamic userId;
  String userEmail;

  UserModel({this.userId,required this.userEmail});


  factory UserModel.fromMap(Map<String,dynamic> map,{dynamic key}){
    return UserModel(userId: key ?? map["userId"],userEmail: map["userEmail"]);
  }


  Map<String,dynamic> toMap({dynamic key}){
    return{
      "userId":key ?? userId,
      "userEmail":userEmail
    };
  }
}