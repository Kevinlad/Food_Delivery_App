import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../module/Cart-module.dart';
class MyProvider extends ChangeNotifier {

  List<Cart_Module> cartList = [];
  List<Cart_Module> newCartList = [];
  late Cart_Module cartModule;
  void addTocart(
      {required String image, required String name, required int price}) {
    cartModule = Cart_Module(image: image, name: name, price: price);
    newCartList.add(cartModule);
    cartList = newCartList;
  }

  get throwCartList {
    return cartList;
  }

  int totalprice() {
    int total = 0;
    cartList.forEach((element) {
      total = total + element.price;
    });
    return total;
  }

  late int deleteIndex;
  void getDeleteIndex(int index) {
    deleteIndex = index;
  }

  void delete() {
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
}
