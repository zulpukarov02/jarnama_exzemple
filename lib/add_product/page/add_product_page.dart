import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jarnama_exzemple/add_product/services/date_time_servic.dart';
import 'package:jarnama_exzemple/add_product/services/image_picer_servic.dart';
import 'package:jarnama_exzemple/components/customformfiled.dart';

// ignore: must_be_immutable
class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);
  final _title = TextEditingController();
  final _descr = TextEditingController();
  final _date = TextEditingController();
  final _phn = TextEditingController();
  final _userName = TextEditingController();
  final _addres = TextEditingController();
  final _price = TextEditingController();
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppProductPage"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        children: [
          CustomFormfield(
            controller: _title,
            hintText: "Title",
          ),
          const SizedBox(height: 12),
          CustomFormfield(
            maxLines: 5,
            controller: _descr,
            hintText: "Desccription",
          ),
          const SizedBox(height: 12),
          ContainerImage(
            images: images,
            onPicked: (value) => images = value,
            delete: (xFile) => images.remove(xFile),
          ),
          const SizedBox(height: 12),
          CustomFormfield(
            focusNode: FocusNode(),
            controller: _date,
            hintText: "DateTime",
            prefixIcon: const Icon(Icons.calendar_month),
            onTap: () async {
              await DateTimeservic.showDateTimePicer(
                  context,
                  (value) =>
                      _date.text = DateFormat(" d MMM, y").format(value));
            },
          ),
          CustomFormfield(
            controller: _phn,
            hintText: "PhoneNumber",
          ),
          CustomFormfield(
            controller: _userName,
            hintText: "User name",
          ),
          CustomFormfield(
            controller: _addres,
            hintText: "Addres",
          ),
          CustomFormfield(
            controller: _price,
            hintText: "Price",
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send),
            label: const Text("Add to FireStore"),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ContainerImage extends StatefulWidget {
  ContainerImage({
    super.key,
    required this.images,
    required this.onPicked,
    required this.delete,
  });
  List<XFile> images;
  final void Function(List<XFile> images) onPicked;
  final void Function(XFile) delete;

  @override
  State<ContainerImage> createState() => _ContainerImageState();
}

class _ContainerImageState extends State<ContainerImage> {
  final service = ImagePicerServic();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget.images.isNotEmpty
            ? SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 120,
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardImage(
                          (widget.images[index]),
                          delete: (xFile) {
                            widget.images.remove(xFile);
                            widget.delete(xFile);
                            setState(() {});
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: () async {
                          final value = await service.pickImage();
                          if (value != null) {
                            widget.onPicked(value);
                            widget.images = value;
                            setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: IconButton(
                    onPressed: () async {
                      final value = await service.pickImage();
                      if (value != null) {
                        widget.onPicked(value);
                        widget.images = value;
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 60,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

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
//  Container(
//       height: 150,
      // child: ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: 5,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       width: 150,
      //       height: 150,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(5),
      //       ),
      //       child: Image.file(
      //         file[index],
      //         fit: BoxFit.fill,
      //       ),
      //     );
      //   },
      // ),
       // ? Wrap(
            //     children:
            //         widget.images.map((e) => CardImage(File(e.path))).toList(),
            //   )