import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarnama_exzemple/components/customformfiled.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);
  final _title = TextEditingController();
  final _descr = TextEditingController();
  final _date = TextEditingController();
  final _phn = TextEditingController();
  final _userName = TextEditingController();
  final _addres = TextEditingController();
  final _price = TextEditingController();
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
          CustomFormfield(
            controller: _descr,
            hintText: "Desccription",
          ),
          CustomFormfield(
            controller: _date,
            hintText: "DateTime",
            onTap: () {
              showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    height:
                        MediaQuery.of(context).copyWith().size.height * 0.25,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                        _date.text = value.toString();
                      },
                      initialDateTime: DateTime.now(),
                      minimumYear: 2000,
                      maximumYear: 3000,
                    ),
                  );
                },
              );
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
