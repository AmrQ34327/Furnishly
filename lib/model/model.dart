import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Account {
  String username;
  String email;
  String phoneNumber;
  String password;
  String mainAddress;
  List<Order> orderList;
  List<CartItem> wishlist;

  Account({
    required this.username,
    required this.email,
    this.password = '',
    this.phoneNumber = '',
    this.mainAddress = '',
    required this.orderList,
    required this.wishlist,
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

  double get totalPrice =>
      hasDiscount ? (price - discount) * quantity : price * quantity;
}

class Order {
  final List<dynamic> orderedItems;
  final double totalPrice;
  final String deliveryDate;
  final String paymentMethod;
  final String deliveryAdress;
  final String name;
  final String phoneNumber;
  final String orderNumber;
  final DateTime orderMadeDate;

  const Order({
    required this.orderMadeDate,
    required this.orderNumber,
    required this.name,
    required this.phoneNumber,
    required this.deliveryAdress,
    required this.orderedItems,
    required this.totalPrice,
    required this.deliveryDate,
    required this.paymentMethod,
  });

  get address => deliveryAdress;
  get date => deliveryDate;
  get total => totalPrice.toStringAsFixed(2);
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

Future<void> sendEmail(String emailAddress) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not send email to $emailAddress';
  }
}

Future<void> sendInquiryEmail(String name, String email, String message) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@furnishly.com',
      query: 'subject=Quick Inquiry from $name&body=Name: $name\nEmail: $email\nMessage: $message',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to support@furnishly.com';
    }
  }

  void openFacebook() async {
  const url = 'https://www.facebook.com/profile.php?id=100064574688755';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not open the link $url';
  }
}

  void openInstagram() async {
  const url = 'https://www.instagram.com/askamuslim';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not open the link $url';
  }
}

  void openX() async {
  const url = 'https://x.com/theislamicummah';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not open the link $url';
  }
}
