import 'package:flutter/material.dart';
import 'package:furnishly/model/model.dart';
import 'dart:core';

import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  Account? _currentUser;

  // Getter to access the user
  Account? get currentUser => _currentUser;

  get wishlist => _currentUser!.wishlist;

  get orderList => _currentUser!.orderList;

  void setUser(Account user) {
    _currentUser = user;
    notifyListeners();
  }

  void makeOrder(Order order) {
    _currentUser!.orderList.add(order);
    notifyListeners();
  }

  void addToWishlist(CartItem item) {
    _currentUser!.wishlist.add(item);
    notifyListeners();
  }

  void removeFromWishlist(String ID) {
    _currentUser!.wishlist.removeWhere((item) => item.id == ID);
    notifyListeners();
  }

  bool isItemInWishList(String ID) {
    var productFound = false;
    // search wishlist
    for (var item in _currentUser!.wishlist) {
      if (item.id == ID) {
        productFound == true;
        break;
      } else {
        productFound == false;
      }
    }
    return productFound;
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
      total += item.totalPrice;
    }
    return total;
  }

  double get subtotal {
    double subtotal = 0;
    for (var item in cart) {
      subtotal += item.price;
    }
    return subtotal;
  }

  double get totalDiscount {
    double totalDiscount = 0;
    for (var item in cart) {
      if (item.hasDiscount) {
        totalDiscount += item.discount;
      }
    }
    return totalDiscount;
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  void decreaseOrderQuantity(List cart, List productsList) {
    // iterate through cart and get each item id and quantity
    for (var cartItem in cart) {
      var productID = cartItem.id;
      var productQuantity = cartItem.quantity;
      for (var product in productsList) {
        // decrease each item quanitty in products list based on it's id
        if (product.id == productID) {
          product.quantity = product.quantity - productQuantity;
          break;
        }
      }
    }
  }
}

 bool isItemInWishList(BuildContext context, String ID) {
    var productFound = false;
    // search wishlist
    for (var item
        in Provider.of<UserProvider>(context, listen: false).wishlist) {
      if (item.id == ID) {
        productFound = true;
        break;
      } else {
        productFound = false;
      }
    }
    return productFound;
  }
