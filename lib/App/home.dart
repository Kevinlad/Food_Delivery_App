import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modernlogintute/App/Cart_Page.dart';
import 'package:modernlogintute/App/Profile.dart';
import 'package:modernlogintute/App/home_page1.dart';
import 'dart:math';

import '../Auth/auth.dart';

class Sliver extends StatefulWidget {
  const Sliver({super.key});

  @override
  State<Sliver> createState() => _SliverState();
}

class _SliverState extends State<Sliver> {
  final ScrollController _controller = ScrollController();

  double _offset = 0.0;
  double data = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _offset = _controller.offset;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildContainer({required String image, required String name}) {
    return Container(
        height: 200.0,
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
                    radius: 50,
                    backgroundColor: Colors.brown[600],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        image,
                        height: 100,
                        width: 150,
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
                              height: 10,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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

  final List<String> imgList = [
    'https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/5fe3257ad6874_json_image_1608721786.webp',
    'https://img.freepik.com/free-psd/banner-template-with-barbeque-design_23-2148522382.jpg?w=360',
    'https://img.freepik.com/free-psd/american-food-banner-template_23-2148484446.jpg?w=360',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            CustomScrollviewAppBar(offset: _offset),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CarouselSlider(
                      items: imgList
                          .map((item) => Container(
                                child: Center(
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    width: 1000,
                                  ),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                    ),

                    // CarouselWithDotsPage(imgList: imgList),
                    SizedBox(
                      height: 20,
                    ),
                    Text('   Special Offer',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 25),
                        )),
                    Row(
                      children: [
                        buildContainer(
                            image: 'asset/image/matar-paneer-2.webp',
                            name: 'Matar Panner'),
                        SizedBox(
                          width: 15,
                        ),
                        buildContainer(
                            image: 'asset/image/mutton-kabab.jpg',
                            name: 'Kabab')
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        buildContainer(
                            image: 'asset/image/pizza.jpeg', name: 'Pizza'),
                        SizedBox(
                          width: 15,
                        ),
                        buildContainer(
                            image: 'asset/image/bir.jpg', name: 'Biryani')
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
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
                          MaterialPageRoute(builder: (conrtext) => Sliver()));
                    },
                  ),
                  GestureDetector(
                      child: CustomIcon(
                          offset: widget.offset,
                          iconData: Icons.emoji_food_beverage),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Sliver2()));
                      }),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CartPage())));
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
