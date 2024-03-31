class CountModel{
  int count;

  CountModel({required this.count});

  @override
  String toString() {
    // TODO: implement toString
    return "$count";
  }


  factory CountModel.fromMap(Map<String,dynamic> map){
    return CountModel(count: map["myCount"]);
  }
}