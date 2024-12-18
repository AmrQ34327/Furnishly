import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:provider/provider.dart';
import 'shared.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/model/model.dart';

class ViewSingleProduct extends StatefulWidget {
  const ViewSingleProduct({
    super.key,
  });

  @override
  State<ViewSingleProduct> createState() => _ViewSingleProductState();
}

class _ViewSingleProductState extends State<ViewSingleProduct> {
  final TextEditingController quantityController = TextEditingController();
  int productQuantity = 1;

  Product getProductData() {
    String productID = ModalRoute.of(context)!.settings.arguments as String;
    final product =
        productList.firstWhere((product) => product.id == productID);
    return product;
  }

  @override
  void initState() {
    super.initState();
    // Initialize the quantityController with the initial product quantity
    quantityController.text = productQuantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var product = getProductData();
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Light shadow
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow direction
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    product.imagePath,
                    width: width * 1,
                    height: height * 0.3,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                product.title,
                style: TextStyle(
                  fontSize:
                      Theme.of(context).primaryTextTheme.bodyMedium!.fontSize,
                  fontWeight:
                      Theme.of(context).primaryTextTheme.bodyMedium!.fontWeight,
                  color: Theme.of(context).primaryTextTheme.bodySmall!.color,
                ),
              ),
              Text(product.description,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).primaryTextTheme.bodySmall!.fontSize,
                    fontWeight: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium!
                        .fontWeight,
                    color: Theme.of(context).primaryTextTheme.bodySmall!.color,
                  )),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).primaryTextTheme.bodyMedium!.fontSize,
                    fontWeight: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium!
                        .fontWeight,
                    color: Theme.of(context).primaryTextTheme.bodySmall!.color,
                  ),
                ),
              ),
              product.hasDiscount
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '${((product.discount / product.price) * 100).round()} % Discount',
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
                              .bodyLarge!
                              .color,
                        ),
                      ),
                    )
                  : const SizedBox(),
              // quantity row
              // make sure quantity can only be number int
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
                    onPressed: () {
                      setState(() {
                        if (productQuantity > 1) {
                          productQuantity--;
                          quantityController.text = productQuantity.toString();
                        }
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: TextField(
                      enabled: false,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20), // make it adaptive
                        fillColor: Color.fromARGB(255, 6, 68, 119),
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
                    onPressed: () {
                      if (productQuantity < product.quantity) {
                        setState(() {
                          productQuantity++;
                          quantityController.text = productQuantity.toString();
                        });
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ButtonStyle(
                  // make it adaptive
                  minimumSize:
                      WidgetStateProperty.all(Size(width * 0.7, height * 0.08)),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      fontSize: width * 0.06, // Adjust the font size here
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  // add to cart logic
                  Provider.of<ProductProvider>(context, listen: false).addToCart(CartItem(
                      id: product.id,
                      title: product.title,
                      description: product.description,
                      imagePath: product.imagePath,
                      price: product.price,
                      hasDiscount: product.hasDiscount,
                      discount: product.discount,
                      quantity: productQuantity,
                      category: product.category));
                  showSuccesDialog('Item Added Successfully', context, duration: 2);
                },
                child: const Text('Add to Cart'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
