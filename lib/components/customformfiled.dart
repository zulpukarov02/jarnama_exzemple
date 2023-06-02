import 'package:flutter/material.dart';

class CustomFormfield extends StatelessWidget {
  const CustomFormfield({
    super.key,
    this.hintText,
    this.controller,
    this.maxLines,
    this.onTap,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
  });
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      maxLines: maxLines,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(hintText ?? ""),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
