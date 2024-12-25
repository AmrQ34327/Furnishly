import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:furnishly/views/cart_page.dart';
import 'package:furnishly/views/shared.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(showSignInOut: false),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(width * 0.025),
          child: Column(
            children: [
              SizedBox(height: height * 0.017 ),
              Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.022),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width * 0.05),
                      bottomRight: Radius.circular(width * 0.05)),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Text(
                      'My Wishlist',
                      style: TextStyle(
                        fontSize: width * 0.075,
                        fontWeight: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .fontWeight,
                        color:
                            Theme.of(context).appBarTheme.titleTextStyle!.color,
                      ),
                    ),
                  ),
                ),
              ),
              Provider.of<UserProvider>(context, listen: false)
                          .wishlist
                          .length <
                      1
                  ? Padding(
                      padding:  EdgeInsets.all(width * 0.25),
                      child: Text(
                        'Your wishlist is empty! Tap the heart icon on the top-right corner of any product image to add it to your wishlist',
                        style : Theme.of(context).primaryTextTheme.bodyMedium
                      ),
                    )
                  : ListView.builder(
                      itemCount: context.watch<UserProvider>().wishlist.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product =
                            Provider.of<UserProvider>(context).wishlist[index];
                        return Padding(
                          padding:  EdgeInsets.all(width * 0.02),
                          child: CartTile2(
                            showIncreaseDecreaseQuantity: false,
                            cartItem: product,
                            productQuantity: product.quantity,
                          ),
                        );
                      }),
              // add new widgets here
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
