import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jarnama_exzemple/add_product/services/date_time_servic.dart';

import 'package:jarnama_exzemple/add_product/services/loading_service.dart';
import 'package:jarnama_exzemple/add_product/services/storage_service.dart';
import 'package:jarnama_exzemple/add_product/services/store_service.dart';
import 'package:jarnama_exzemple/components/container_image.dart';
import 'package:jarnama_exzemple/components/customformfiled.dart';
import 'package:jarnama_exzemple/model/product_model.dart';

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
            onPressed: () async {
              LoadingService().showLoading(context);
              final urls = await StorageService().uploudImages(images);
              final product = Product(
                images: urls,
                title: _title.text,
                description: _descr.text,
                dateTime: _date.text,
                phoneNumber: _phn.text,
                userName: _userName.text,
                addres: _addres.text,
                price: _price.text,
              );
              await StoreService().saveProduct(product);
              // ignore: use_build_context_synchronously
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.send),
            label: const Text("Add to FireStore"),
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