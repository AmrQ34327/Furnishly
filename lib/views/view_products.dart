import 'package:flutter/material.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/model/model.dart';
import 'package:furnishly/views/shared.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({
    super.key,
  });

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  String query = '';
  var filteredProductsList = [];
  final TextEditingController searchBarController = TextEditingController();
  List<dynamic> shownProducts = productList;
  Set<String> selectedCategories = {};
  var showeDiscountedProducts = false;

  bool isinitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isinitialized) {
      final category = ModalRoute.of(context)!.settings.arguments as String?;
      setState(() {
        if (category != null && category != 'showDiscount') {
          shownProducts = showProductsByCategory(category);
          selectedCategories.add(category);
        } else if (category != null && category == 'showDiscount') {
          showeDiscountedProducts = true;
           shownProducts = productList.where((product) => product.hasDiscount).toList();
        } else {
          shownProducts = productList;
        }
      });
      isinitialized = true;
    }
  }

  // Function to filter products based on search query
  void updateSearch(String query) {
    setState(() {
      filteredProductsList = productList
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void updateFilter(String category, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCategories.add(category);
      } else {
        selectedCategories.remove(category);
      }

      // Reapply both filters (category and "On Sale")
      if (selectedCategories.isEmpty && !showeDiscountedProducts) {
        shownProducts = productList;
      } else {
        shownProducts = productList.where((product) {
          final categoryMatch = selectedCategories.isEmpty ||
              selectedCategories.contains(product.category.title);
          final saleMatch = !showeDiscountedProducts || product.hasDiscount;
          return categoryMatch && saleMatch;
        }).toList();
      }
    });
  }

  @override
  build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20), // make it adaptive
            TextField(
              controller: searchBarController,
              onChanged: (value) {
                setState(() {
                  query = value; // Update query whenever the text changes
                });
                updateSearch(query);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(38.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            searchBarController.text.isNotEmpty
                ? SizedBox(
                    height: filteredProductsList.isEmpty
                        ? height * 0.2
                        : height * 0.4,
                    child: filteredProductsList.isEmpty
                        ? const Center(
                            child: Text(
                              'No products found',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredProductsList.length,
                            itemBuilder: (context, index) {
                              final product = filteredProductsList[index];
                              return ListTile(
                                  leading: Container(
                                    height: height * 0.4,
                                    width: width * 0.25,
                                    child: Image.asset(
                                      product.imagePath,
                                      width: width * 0.2,
                                      height: height * 0.2,
                                      fit: BoxFit.fill,
                                    ),
                                  ), // Example icon
                                  title: Text(product.title),
                                  subtitle: Text(product.description),
                                  trailing: Text('\$${product.price}'));
                            }))
                : const SizedBox(),
            // add new widgets here
           query.isEmpty? Wrap(spacing: 5.0, children: [
              FilterChip(
                  label:
                      const Text("Office"), // blue background with yellow text
                  selected: selectedCategories.contains("Office"),
                  onSelected: (bool selected) {
                    updateFilter("Office", selected);
                  }),
              FilterChip(
                  label: const Text("Living Room"),
                  selected: selectedCategories.contains("Living Room"),
                  onSelected: (bool selected) {
                    updateFilter("Living Room", selected);
                  }),
              FilterChip(
                  label: const Text("Bedroom"),
                  selected: selectedCategories.contains("Bedroom"),
                  onSelected: (bool selected) {
                    updateFilter("Bedroom", selected);
                  }),
              FilterChip(
                  label: const Text("Dining Room"),
                  selected: selectedCategories.contains("Dining Room"),
                  onSelected: (bool selected) {
                    updateFilter("Dining Room", selected);
                  }),
              FilterChip(
                  label: const Text("Outdoors"),
                  selected: selectedCategories.contains("Outdoors"),
                  onSelected: (bool selected) {
                    updateFilter("Outdoors", selected);
                  }),
            ]): SizedBox(),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: query.isEmpty? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "On Sale",
                    style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodySmall!
                            .color),
                  ),
                  Checkbox(
                    value: showeDiscountedProducts,
                    onChanged: (value) {
                      setState(() {
                        showeDiscountedProducts = value!;
                        // When "On Sale" is toggled, apply both filters (category and "On Sale")
                        if (selectedCategories.isEmpty) {
                          // If no categories are selected, just filter by "On Sale"
                          if (showeDiscountedProducts) {
                            shownProducts = productList
                                .where((product) => product.hasDiscount)
                                .toList();
                          } else {
                            shownProducts = productList;
                          }
                        } else {
                          // Apply both "On Sale" and category filters
                          shownProducts = productList.where((product) {
                            final categoryMatch = selectedCategories
                                .contains(product.category.title);
                            final saleMatch =
                                !showeDiscountedProducts || product.hasDiscount;
                            return categoryMatch && saleMatch;
                          }).toList();
                        }
                      });
                    },
                    checkColor: Colors.white,
                    activeColor:
                        Theme.of(context).primaryTextTheme.bodySmall!.color,
                  ),
                ],
              ): const SizedBox(),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10, // Space between columns
                  mainAxisSpacing: 10, // Space between rows
                  childAspectRatio: 0.75, // Width-to-height ratio
                ),
                itemCount: shownProducts.length, // Total number of items
                itemBuilder: (context, index) {
                  final product = shownProducts[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle item tap using it's ID
                      Navigator.pushNamed(context, '/viewSingleProduct',
                          arguments: product.id);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MyImageContainer(
                            child: Image.asset(
                              product.imagePath,
                              width: width * 0.4, // make it adaptive
                              height: height * 0.14,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.title,
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
                                  .bodySmall!
                                  .color,
                            ),
                          ),
                          SizedBox(height: 5),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '\$${product.price}',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall!
                                    .fontSize,
                                fontWeight: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium!
                                    .fontWeight,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall!
                                    .color,
                              ),
                            ),
                          ),
        
                          // add new widgets here
                        ]),
                  );
                },
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
