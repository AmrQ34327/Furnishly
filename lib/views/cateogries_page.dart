import 'package:flutter/material.dart';
import 'package:furnishly/views/shared.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar() ,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cateogries Page Under Construction',
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
    drawer: const MyDrawer(),);
  }
}
