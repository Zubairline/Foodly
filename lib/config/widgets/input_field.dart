import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.textInputType,
    this.textInputAction,
    this.hintText,
    this.validator,
    this.controller,
    this.obscureText,
    this.suffixIcon,
    this.border,
    this.prefixIcon,
    this.filled, this.label,
  });

  final TextEditingController? controller;
  final InputBorder? border;
  final bool? obscureText;
  final bool? filled;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(color: textSecondaryColor),
        filled: filled ?? true,
        fillColor: Colors.white,
        border: border,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
