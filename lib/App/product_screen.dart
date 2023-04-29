import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modernlogintute/App/Detail_page.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  final String collection;
  const ProductScreen({super.key, required this.id, required this.collection});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('categories')
              .doc(widget.id)
              .collection(widget.collection)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
            if (!snapshort.hasData) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return GridView.builder(
                itemCount: snapshort.data!.docs.length,
                // shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  var data = snapshort.data!.docs[index];
                  return Scaffold(
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: buildContainer(
                            productImage: data["productImage"],
                            productName: data["productName"],
                            productPrice: data["productPrice"],
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) => FoodDetails(
                                          image: data['productImage'],
                                          price: data['productPrice'],
                                          name: data['productName']))));
                            }),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Widget buildContainer({
    required Function()? onTap,
    required String productImage,
    required String productName,
    required int productPrice,
  }) {
    return Container(
        height: 280.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown[300],
              ),
              child: Column(
                children: [
                  Image.network(
                    productImage,
                    height: 150,
                    width: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                            ),
                            Row(
                              children: [
                                Text(
                                  " \$${productPrice}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.orange,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBarIndicator(
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  rating: 3.5,
                                  itemCount: 5,
                                  itemSize: 15,
                                  unratedColor: Colors.amber.withAlpha(50),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "3.5",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
