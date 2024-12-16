import 'package:flutter/material.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/views/shared.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.012),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).primaryTextTheme.bodyLarge!.fontSize,
                    fontWeight: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .fontWeight,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10, // Space between columns
                    mainAxisSpacing: 10, // Space between rows
                    childAspectRatio: 1.0, // Width-to-height ratio
                  ),
                  itemCount: categoriesList.length, // Total number of items
                  itemBuilder: (context, index) {
                    final category = categoriesList[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle item tap
                        Navigator.pushNamed(context, '/viewProducts', arguments: category.title);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              category.imagePath,
                              width: width * 0.4, // make it adaptive
                              height: height * 0.2,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 10),
                            Text(
                              category.title,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium!
                                    .fontSize,
                                fontWeight: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium!
                                    .fontWeight,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            )
                          ]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
      drawer: const MyDrawer(),
    );
  }
}
