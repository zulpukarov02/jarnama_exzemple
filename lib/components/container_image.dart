import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jarnama_exzemple/add_product/services/image_picer_servic.dart';
import 'package:jarnama_exzemple/components/card_image.dart';

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
