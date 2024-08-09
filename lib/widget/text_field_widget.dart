import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obsecure;
  final TextInputType textInputType;
  final String? errorText;
  final void Function(String)? onChange;
  const TextFieldCustomWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obsecure,
      required this.textInputType,
      required this.errorText,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obsecure,
      keyboardType: textInputType,
      decoration: InputDecoration(
          errorText: errorText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white60)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white60)),
      onChanged: onChange,
    );
  }
}
