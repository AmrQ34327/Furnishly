import 'package:flutter/material.dart';
import 'package:furnishly/model/model.dart';
import 'dart:core';

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

  // and changes main address
  void addAddress(String address) {
    _currentUser!.mainAddress = address;
    notifyListeners();
  }

  // To-D0 Make the methods add to wishlist and add to orders
}

class ProductProvider extends ChangeNotifier {
  var cart = [];

  bool get isCartEmpty => cart.isEmpty;

  void addToCart(CartItem item) {
    cart.add(item);
    notifyListeners();
  }

  void removeFromCart(String id) {
    cart.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    item.quantity = newQuantity;
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in cart) {
      total += item.price;
    }
    return total;
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  void cartCheckout() {
    // subtract order quantity
    // add order to my orders list
    // clear cart
  }
}
