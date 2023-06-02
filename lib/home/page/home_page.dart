import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarnama_exzemple/add_product/add_product.dart';
import 'package:jarnama_exzemple/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Stream<QuerySnapshot> readTodos() {
    final db = FirebaseFirestore.instance;
    return db.collection("products").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        title: const Text("HomePage"),
      ),
      body: StreamBuilder(
        stream: readTodos(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error!.toString()));
          } else if (snapshot.hasData) {
            final List<Product> products =
                // ignore: unnecessary_cast
                snapshot.data!.docs
                    // ignore: unnecessary_cast
                    .map(
                      (d) => Product.fromMap(d.data() as Map<String, dynamic>),
                    )
                    .toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return Card(
                    color: Color(0xffE5E5E5),
                    child: Column(
                      children: [
                        product.images != null
                            ? SizedBox(
                                height: 200,
                                child: PageView.builder(
                                  itemCount: product.images!.length,
                                  itemBuilder: (context, index) {
                                    final image = product.images![index];
                                    return Image.network(image);
                                  },
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 30),
                        ListTile(
                          title: Text(product.userName),
                          leading: Text(product.title),
                          subtitle: Text(product.description),
                          trailing: Text(product.price ?? ""),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(product.phoneNumber),
                        )
                      ],
                    ));
              },
            );
          } else {
            return const Center(child: Text("ERROR"));
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.menu_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          );
        },
      ),
    );
  }
}
    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Checkbox(
                    //       value: todo.isCompleted,
                    //       onChanged: (v) async {
                    //         await updateTodo(todo);
                    //       },
                    //     ),
                    //     IconButton(
                    //         onPressed: () async {
                    //           await deletTodo(todo);
                    //         },
                    //         icon: const Icon(Icons.delete))
                    //   ],
                    // ),