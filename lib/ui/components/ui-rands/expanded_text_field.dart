import 'package:flutter/material.dart';

class ExpandedTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const ExpandedTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextField(

        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(

                  color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[500])


        ),
        autofocus: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        maxLines: null,
      ),
    );
  }
}
