import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback myFunction;
  const MyButton({super.key, required this.text, required this.myFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GestureDetector(
        onTap: () => myFunction(),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffEFF1FA),
            boxShadow:const [
              BoxShadow(color: Colors.white,blurRadius: 1,spreadRadius: 1),
              BoxShadow(color: Colors.blue,blurRadius: 1,spreadRadius: 1)

            ]
          ),
          width: 500,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
          ),
        ),
      ),
    );
  }
}
