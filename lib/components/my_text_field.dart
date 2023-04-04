import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
            )
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
            )
          ),
          fillColor: Color.fromARGB(255, 202, 204, 206),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: colorsWhite()
          ),
        ),
      ),
    );
  }
  Color colors() => Color.fromARGB(255, 205, 206, 206);
  Color colorsWhite() => Color.fromARGB(255, 255, 255, 255);
}