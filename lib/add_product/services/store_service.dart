import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarnama_exzemple/model/product_model.dart';

class StoreService {
  final db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product) async {
    await db.collection("products").add(product.toMap());
  }
}
