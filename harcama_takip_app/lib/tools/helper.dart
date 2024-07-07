
import 'package:flutter/material.dart';

import '../model/card_model.dart';

class AppHelper {
  static List<String> turkBankalari = [
    "Akbank",
    "AlternatifBank",
    "AnadoluBank",
    "Arap Türk Bankası",
    "Bank of China Turkey",
    "Burgan Bank",
    "Citibank",
    "DenizBank",
    "Deutsche Bank",
    "Fibabanka",
    "Garanti BBVA",
    "Halkbank",
    "HSBC Bank",
    "ING Bank",
    "İş Bankası",
    "Kuveyt Türk Katılım Bankası",
    "QNB Finansbank",
    "Şekerbank",
    "VakıfBank",
    "Yapı Kredi Bankası",
    "Ziraat Bankası",
  ];

  static const Map<String, Color> bankColors = {
    "Akbank": Color(0xFF0064B0), // Akbank Mavisi
    "AlternatifBank": Color(0xFFF26522), // AlternatifBank Turuncu
    "AnadoluBank": Color(0xFFE60012), // AnadoluBank Kırmızı
    "Arap Türk Bankası": Color(0xFF00A99D), // Arap Türk Bankası Turkuaz
    "Bank of China Turkey": Color(0xFFDA291C), // Bank of China Kırmızı
    "Burgan Bank": Color(0xFF0077BB), // Burgan Bank Mavisi
    "Citibank": Color(0xFF004889), // Citibank Mavisi
    "Denizbank": Color(0xFF0059B2), // Denizbank Mavisi
    "Deutsche Bank": Color(0xFF001479), // Deutsche Bank Mavisi
    "Fibabanka": Color(0xFF2778be), // Fibabanka Kırmızı
    "Garanti BBVA": Color(0xFF187545), // Garanti BBVA Kırmızı
    "Halkbank": Color(0xFFE81123), // Halkbank Kırmızı
    "HSBC Bank": Color(0xFFDC0000), // HSBC Bank Kırmızı
    "ING Bank": Color(0xFFFF6600), // ING Bank Turuncu
    "İş Bankası": Color(0xFFE81123), // İş Bankası Kırmızı
    "Kuveyt Türk Katılım Bankası": Color(0xFF00A499), // Kuveyt Türk Turkuaz
    "QNB Finansbank": Color(0xFFF26522), // QNB Finansbank Turuncu
    "Şekerbank": Color(0xFF91BE4F), // Şekerbank Yeşil
    "VakıfBank": Color(0xFFfcb100), //
    "Yapı Kredi Bankası": Color(0xFF0068B3), // Yapı Kredi Mavisi
    "Ziraat Bankası": Color(0xFFb9201f), // Ziraat Bankası Yeşil
  };

  static Color getColor(String bankName) {
    return bankColors[bankName] ?? Colors.grey;
  }

  static Image? getImage(String bankName) {
    final normalizedBankName = bankName
        .toLowerCase()
        .replaceAll(
            RegExp(r'\s+'), '');

    if (turkBankalari.contains(bankName)) {
      return Image(
        width: 60,
        height: 60,
        image: AssetImage(
          'assets/${normalizedBankName}_logo.png',
        ),
        errorBuilder: (_, __, ___) => const Image(
            image: AssetImage(
                'assets/generic_bank_logo.png')), // Genel banka logosu
        loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
            ? child
            : const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
      );
    } else {
      return null; // Banka logosu bulunamadıysa null döndür
    }
  }

  static String getInitials(String text) {
    if (text.isEmpty) return '';

    var words = text.split(' ');
    var initials = '';

    for (var word in words) {
      if (word.isNotEmpty && word[0].toUpperCase() != word[0].toLowerCase()) {

        initials += word[0].toUpperCase();
      }
    }

    return initials;
  }
}

 extension AppExtensionHelper on BuildContext{

  TextStyle getNormalTextStyle(double size) => TextStyle(fontSize: getFontSize(size));
  TextStyle getColorTextStyle(double size,Color color) => TextStyle(fontSize: getFontSize(size),color: color);
  TextStyle getBoldColorTextStyle(double size,Color color) => TextStyle(fontSize: getFontSize(size),fontWeight: FontWeight.bold,color: color);
  TextStyle getBoldTextStyle(double size)=>  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: getFontSize(size));
  double getDeviceHeight()=>MediaQuery.of(this).size.height;
  double getDeviceWidth()=> MediaQuery.of(this).size.width;
  EdgeInsets getAllPadding()=>EdgeInsets.all(getDeviceHeight()*0.1);
  EdgeInsets getSymetricPadding()=>EdgeInsets.symmetric(horizontal: getDeviceHeight()*0.1);
 double getFontSize(double size) => size;



 getPiePercent(List<CardModel>cards){
   dynamic result = 0;
   for (var element in cards){
     result += element.price;
   }

 }
}
