import 'package:flutter/material.dart';
import 'package:harcama_takip_app/tools/helper.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final dynamic price;

  const MyListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      elevation: 5,
      child: ListTile(
        leading: AppHelper.getImage(title),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subTitle,
          style: context.getColorTextStyle(13, Colors.grey.shade900),
        ),
        trailing: Text(
          "₺${price.toString()}",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
