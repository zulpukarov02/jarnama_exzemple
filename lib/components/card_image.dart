import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardImage extends StatelessWidget {
  const CardImage(
    this.file, {
    Key? key,
    required this.delete,
  }) : super(key: key);
  final XFile file;
  final void Function(XFile) delete;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 150,
    //   height: 150,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //   ),
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Stack(
        children: [
          Image.file(
            File(file.path),
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () => delete(file),
              child: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
