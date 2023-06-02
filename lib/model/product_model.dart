// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  const Product({
    required this.images,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.phoneNumber,
    required this.userName,
    required this.addres,
    this.price,
  });
  final List<String>? images;
  final String title;
  final String description;
  final String dateTime; //this is date time we can change type to time
  final String phoneNumber;
  final String userName;
  final String addres;
  final String? price;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'images': images,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'addres': addres,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<dynamic>))
          : null,
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: map['dateTime'] as String,
      phoneNumber: map['phoneNumber'] as String,
      userName: map['userName'] as String,
      addres: map['addres'] as String,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
