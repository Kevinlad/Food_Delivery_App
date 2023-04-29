import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modernlogintute/App/Cart_Page.dart';
import 'package:modernlogintute/App/provider.dart/my_provider.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class FoodDetails extends StatefulWidget {
  final String image;
  final int price;
  final String name;

  FoodDetails({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
  }) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int num = 1;

  bool isAdded = false;

  void increment() {
    setState(() {
      num++;
    });
  }

  void decrement() {
    setState(() {
      num--;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 50,
              ),
              Positioned(
                  child: Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.fitWidth)),
              )),
              Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sliver()));
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.shopping_cart_checkout_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        },
                      ),
                    ],
                  )),
            ],
          ),
          Flexible(
              child: Container(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 30, color: Colors.cyanAccent),
                  ),
                  SizedBox(
                    height: 10,
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
                      SizedBox(
                        width: 110,
                      ),
                      Text(
                        "1500",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "comments",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Icon(Icons.location_on),
                    Text("4.7 km", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 200),
                    Icon(Icons.access_time_filled_rounded),
                    Text("32 min", style: TextStyle(fontSize: 12)),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Introduce",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Based in Lancaster, PA. WebstaurantStore is the largest online restaurant supply store servicing professionals and individual customers worldwide. With hundreds of thousands of products available and millions of orders shipped, we have everything your business needs to function at its best. Over the years we have expanded our selection of commercial equipment and wholesale supplies to include healthcare, educational, food, beverage, office, parts and hotel supplies",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: 115,
        padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 15, right: 15, bottom: 15, left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.remove,
                      color: Colors.grey,
                    ),
                    onTap: decrement,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "$num",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                    onTap: increment,
                  )
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 20, right: 20, bottom: 20, left: 20),
              child: InkWell(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  provider.addTocart(
                      image: widget.image,
                      name: widget.name,
                      price: widget.price);
                  MotionToast.success(
                    description: Text("Add to the Cart"),
                    width: 350,
                    height: 80,
                    title: Text(
                      "Added",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    animationType: AnimationType.fromBottom,
                    position: MotionToastPosition.bottom,
                    animationCurve: Curves.bounceInOut,
                    barrierColor: Colors.grey.withOpacity(0.5),
                  ).show(context);
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
