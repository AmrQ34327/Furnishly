import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

// transfare to controller section in the end
class UserProvider extends ChangeNotifier {
  Account? _currentUser;

  // Getter to access the user
  Account? get currentUser => _currentUser;

  void setUser(Account user) {
    _currentUser = user;
    notifyListeners();
  }

  void updateUsername(String newUsername) {
    _currentUser!.username = newUsername;
    notifyListeners();
  }

  // this will probably be of no use
  void updateEmail(String newEmail) {
    _currentUser!.email = newEmail;
    notifyListeners();
  }

  void setPassword(String newPassword) {
    _currentUser!.password = newPassword;
    notifyListeners();
  }

  void setPhoneNumber(String newPhoneNumber) {
    _currentUser!.phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  /// Adds an address to the user's address list and changes main address
  void addAddress(String address) {
    _currentUser!.mainAddress = address;
    notifyListeners();
  }

  // To-D0 Make the methods add to wishlist and add to orders
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
  // dont forget the discount
  double get discountSubtract => price * discount;
  double get totalPrice =>
      (hasDiscount ? price - discountSubtract : price) * quantity;
}
