import 'dart:core';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Account {
  @HiveField(0)
  String username;
  @HiveField(1)
  String email;
  @HiveField(2)
  String phoneNumber;
  @HiveField(3)
  String password;
  @HiveField(4)
  String mainAddress;
  @HiveField(5)
  List<Order> orderList;
  @HiveField(6)
  List<CartItem> wishlist;
  @HiveField(7)
  List<dynamic> userCart;

  Account({
    required this.username,
    required this.email,
    this.password = '',
    this.phoneNumber = '',
    this.mainAddress = '',
    required this.orderList,
    required this.wishlist,
    required this.userCart,
  });
}

@HiveType(typeId: 2)
class Product {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String imagePath;
  @HiveField(4)
  double price;
  @HiveField(5)
  bool hasDiscount;
  @HiveField(6)
  double discount;
  @HiveField(7)
  int quantity;
  @HiveField(8)
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

@HiveType(typeId: 4)
class Category {
  @HiveField(0)
  String title;
  @HiveField(1)
  String imagePath;
  Category({
    required this.title,
    required this.imagePath,
  });
}

@HiveType(typeId: 3)
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

@HiveType(typeId: 1)
class Order {
  @HiveField(0)
  final List<dynamic> orderedItems;
  @HiveField(1)
  final double totalPrice;
  @HiveField(2)
  final String deliveryDate;
  @HiveField(3)
  final String paymentMethod;
  @HiveField(4)
  final String deliveryAdress;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final String phoneNumber;
  @HiveField(7)
  final String orderNumber;
  @HiveField(8)
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
    query:
        'subject=Quick Inquiry from $name&body=Name: $name\nEmail: $email\nMessage: $message',
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
