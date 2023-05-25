import 'package:flutter/material.dart';

class CustomFormfield extends StatelessWidget {
  const CustomFormfield({
    super.key,
    this.hintText,
    this.controller,
    this.maxLines,
    this.onTap,
  });
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
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
