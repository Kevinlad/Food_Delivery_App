import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modernlogintute/App/Cart_Page.dart';

import 'package:modernlogintute/App/product_screen.dart';
import 'package:modernlogintute/App/provider.dart/my_provider.dart';

import 'package:modernlogintute/module/food.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../Auth/auth.dart';
import '../Cloud Messaging/Fcm.dart';

import 'home.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final ScrollController _controller = ScrollController();
  double _offset = 0.0;
  double data = 0.0;
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _offset = _controller.offset;
      });
    });
    // notificationServices.showNotification(message)
    // notificationServices.firebaseInit();
    // notificationServices.getRfreshToken();
    // notificationServices.getDeviceToken().then((value) {
    //   print("Device Token");
    //   print(value);
    // });

    notificationServices.requestPermission();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildContainer(
      {required String image, required String name, required int price}) {
    return Container(
        height: 250.0,
        width: 160,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown[300],
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.brown[600],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        image,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                            ),
                            Text("\$${price}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
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

  categoriesContainer(
      {required String image, required String name, required onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 15),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomScrollviewAppBar(offset: _offset),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> StreamSnapShort) {
                    if (!StreamSnapShort.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: StreamSnapShort.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return categoriesContainer(
                              image: StreamSnapShort.data!.docs[index]["image"],
                              name: StreamSnapShort.data!.docs[index]["name"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                              collection: StreamSnapShort
                                                  .data!.docs[index]['name'],
                                              id: StreamSnapShort
                                                  .data!.docs[index].id,
                                            )));
                              });
                        }));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Text('  Most Popular Food',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.blue, letterSpacing: .5, fontSize: 25),
                )),
            Row(
              children: [
                buildContainer(
                    image: 'asset/image/pizza.jpeg', name: 'Pizza', price: 50),
                SizedBox(
                  width: 20,
                ),
                buildContainer(
                    image: 'asset/image/dhosa.jpg', name: 'Dhosa', price: 60),
              ],
            ),
            Row(
              children: [
                buildContainer(
                    image: 'asset/image/chinese.jpeg',
                    name: 'Chinnese',
                    price: 50),
                SizedBox(
                  width: 20,
                ),
                buildContainer(
                    image: 'asset/image/kabab.webp', name: 'Kabab', price: 70),
              ],
            )
          ],
        ),
      )),
    ));
  }
}

class CustomScrollviewAppBar extends StatefulWidget {
  const CustomScrollviewAppBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  final double offset;

  @override
  State<CustomScrollviewAppBar> createState() => _CustomScrollviewAppBarState();
}

class _CustomScrollviewAppBarState extends State<CustomScrollviewAppBar> {
  double topChange = 100;
  Widget change(double width) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      top: 12,
      left: 25,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 50,
        width: widget.offset > 30 ? 20 : width,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: widget.offset > 30
              ? const Icon(
                  Icons.search,
                  color: Colors.white,
                )
              : TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.black.withOpacity(.7),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const double maxExtent = 123;
    const double minExtent = 80;
    final double shrinkOffset = widget.offset;
    final expendPercentage =
        1.0 - min(1, shrinkOffset / (maxExtent - minExtent));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: minExtent + (maxExtent - minExtent) * expendPercentage,
      width: width,
      color: Colors.red,
      child: Stack(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: change(width * .8)),
          // InkWell(
          Positioned(
            top: 22,
            right: 10,
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: InkWell(
                    child: const Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EditProfile()));
                    })),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: widget.offset > 30 ? 25 : 70,
            left: widget.offset > 30 ? 60 : 0,
            right: widget.offset > 30 ? 50 : 0,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: widget.offset > 30 ? width * .80 : width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child:
                        CustomIcon(offset: widget.offset, iconData: Icons.home),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (conrtext) => HomePage()));
                    },
                  ),
                  GestureDetector(
                      child: CustomIcon(
                          offset: widget.offset,
                          iconData: Icons.emoji_food_beverage),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoriesPage()));
                      }),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    child: CustomIcon(
                        offset: widget.offset, iconData: Icons.shopping_cart),
                  ),
                  GestureDetector(
                    onTap: signOut,
                    child: CustomIcon(
                        offset: widget.offset, iconData: Icons.logout_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final double offset;
  final IconData iconData;
  const CustomIcon({super.key, required this.offset, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            offset > 30 ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
        decoration: offset > 30
            ? const BoxDecoration()
            : BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          iconData,
          color: offset > 30 ? Colors.white : Colors.red,
        ));
  }
}
