import 'package:flutter/material.dart';
import 'package:myapp/views/shared.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar() ,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cart Page Under Construction',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: const MyBottomNavigationBar(),
    drawer: const MyDrawer());
  }
}