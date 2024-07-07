class CardModel{
  dynamic cardId;
  String cardName;
  String paymentName;
  dynamic price;

  CardModel({this.cardId,required this.cardName,required this.paymentName,this.price});

  factory CardModel.fromMap(Map<String,dynamic>map,{dynamic key}){
    return CardModel(cardId: key ?? map["cardId"],cardName: map["cardName"], paymentName: map["paymentName"],price: map["price"]);
  }


  Map<String,dynamic> toMap({dynamic key}){
    return{
      "cardId":key ?? cardId,
      "cardName":cardName,
      "paymentName":paymentName,
      "price":price
    };
  }

  Map<String,dynamic> toUpdatedMap(String newCardPaymentName,dynamic newPrice){
    return {
      "cardId":cardId,
      "cardName":cardName,
      "paymentName":newCardPaymentName,
      "price":newPrice
    };
  }
}