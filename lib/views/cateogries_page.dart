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
          padding:  EdgeInsets.all(width * 0.02),
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.012),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Categories',
                  style : Theme.of(context).primaryTextTheme.bodyLarge,
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
                        Navigator.pushNamed(context, '/viewProducts',
                            arguments: category.title);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors
                                      .grey.shade300, // Light border color
                                  width: 2, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    width * 0.04), // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.2), // Light shadow
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // Shadow direction
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(width * 0.04),
                                child: Image.asset(
                                  category.imagePath,
                                  width: width * 0.4, // make it adaptive
                                  height: height * 0.2,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
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
