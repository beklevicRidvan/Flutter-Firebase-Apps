import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureTextValue;
  final Widget? icon;
  const MyTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureTextValue,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(

        controller: controller,
        obscureText: obscureTextValue,
        decoration: InputDecoration(

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey, width: 0.1)),
          suffixIcon: icon,
          fillColor: const Color(0xffE1EDFA),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
