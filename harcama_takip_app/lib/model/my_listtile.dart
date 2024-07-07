import 'package:flutter/material.dart';
import 'package:harcama_takip_app/tools/helper.dart';

class MyListTile extends StatelessWidget {
  final String id;
  final String title;
  final String subTitle;
  final dynamic price;
  final Function deleteFunc;
  final Function updateFunc;

  const MyListTile(
      {super.key,
        required this.updateFunc,
        required this.deleteFunc,
        required this.id,
      required this.title,
      required this.subTitle,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        deleteFunc();
      },
      child: Card(
        shadowColor: Colors.white,
        color: Colors.white,
        margin: const EdgeInsets.all(16),
        elevation: 5,
        child: ListTile(
          onTap: () => updateFunc(),
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
      ),
    );
  }
}
