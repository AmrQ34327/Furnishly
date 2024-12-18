import 'dart:core';
import 'package:flutter/material.dart';

class Account {
  String username;
  String email;
  String phoneNumber;
  String password;
  String mainAddress;
  var orderList;
  var wishlist;

  Account({
    required this.username,
    required this.email,
    this.password = '',
    this.phoneNumber = '',
    this.mainAddress = '',
    this.orderList = const [],
    this.wishlist = const [],
  });
}




class Product {
  String id;
  String title;
  String description;
  String imagePath;
  double price;
  bool hasDiscount;
  double discount;
  int quantity;
  Category category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.hasDiscount,
    required this.discount,
    required this.quantity,
    required this.category,
  });
}

class Category {
  String title;
  String imagePath;
  Category({
    required this.title,
    required this.imagePath,
  });
}

class CartItem extends Product {
  CartItem(
      {required super.id,
      required super.title,
      required super.description,
      required super.imagePath,
      required super.price,
      required super.hasDiscount,
      required super.discount,
      required super.quantity,
      required super.category});

  double get totalPrice => hasDiscount ? price - discount : price * quantity;
}



