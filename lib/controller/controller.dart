import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:furnishly/main.dart';

class UserProvider extends ChangeNotifier {
  final Box<Account> accountsBox;

  UserProvider(this.accountsBox);

  Account? _currentUser;

  // Getter to access the user
  Account? get currentUser => _currentUser;

  get wishlist => _currentUser!.wishlist;

  get orderList => _currentUser!.orderList;

  void addToCart(CartItem item) {
    _currentUser!.userCart.add(item);
    notifyListeners();
  }

  double get totalDiscount {
    double totalDiscount = 0;
    for (var item in _currentUser!.userCart) {
      if (item.hasDiscount) {
        totalDiscount = totalDiscount + item.discount * item.quantity;
      }
    }
    return totalDiscount;
  }

  double get totalPrice {
    double total = 0;
    for (var item in _currentUser!.userCart) {
      total += item.totalPrice;
    }
    return total;
  }

  double get subtotal {
    double subtotal = 0;
    for (var item in _currentUser!.userCart) {
      subtotal += item.price;
    }
    return subtotal;
  }

  void removeFromCart(String id) {
    _currentUser!.userCart.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _currentUser!.userCart.clear();
    notifyListeners();
  }

  void saveLocalAccount(String uid) {
    accountsBox.put(uid, _currentUser!);
    notifyListeners();
  }

  void loadLocalAccount(String uid) {
    _currentUser = accountsBox.get(uid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setUser(Account? user) {
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
        productFound = true;
        break;
      } else {
        productFound = false;
      }
    }
    return productFound;
  }

  void updateUsername(String newUsername) {
    _currentUser!.username = newUsername;
    notifyListeners();
  }

  void updateEmailAndPasswordLocally(String newEmail, [String? newPassword]) {
    // for when signing in after updating email with firebase 
    // and verifying it
    if (_currentUser != null) {
      if (newEmail != _currentUser!.email) {
        _currentUser!.email = newEmail;
        saveLocalAccount(FirebaseAuth.instance.currentUser!.uid);
        notifyListeners();
      }// for when a password is resetted using firebase
      if (newPassword != _currentUser!.password && newPassword != null) {
        _currentUser!.password = newPassword;
        saveLocalAccount(FirebaseAuth.instance.currentUser!.uid);
        notifyListeners();
      }
    }
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

  List<String> outOfStockProducts() {
    List<String> resultList = [];
    // iterate through every cart item
    for (var cartItem in cart) {
      var cartItemID = cartItem.id;
      var theItemInProductList =
          productList.firstWhere((product) => product.id == cartItemID);
      // check if it's quantity is more than the quantity of it in products list
      if (theItemInProductList.quantity < cartItem.quantity) {
        resultList = [
          theItemInProductList.title,
          theItemInProductList.quantity.toString()
        ];
        break;
      }
    }
    return resultList;
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
        totalDiscount = totalDiscount + item.discount * item.quantity;
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
  for (var item in Provider.of<UserProvider>(context, listen: false).wishlist) {
    if (item.id == ID) {
      productFound = true;
      break;
    } else {
      productFound = false;
    }
  }
  return productFound;
}


