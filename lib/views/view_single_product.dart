import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:provider/provider.dart';
import 'shared.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool isFavorited = false;
  User? _currentUser;

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
    // Defer the wishlist check until the widget is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _currentUser = user;
          if (_currentUser != null) {
            // Get the product ID and check if it's in the wishlist
            var product = getProductData();
            isFavorited = isItemInWishList(context, product.id);
          }
        });
      });
    });
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
              MyImageContainer(
                child: Stack(
                  children: [
                    Image.asset(
                      product.imagePath,
                      width: width * 1,
                      height: height * 0.3,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                          onPressed: () {
                            if (_currentUser == null) {
                              showFailureDialog(
                                  'Sign in to add to wishlist', context);
                            } else {
                              if (!isFavorited) {
                                // favotire it and add to wishlist
                                setState(() {
                                  isFavorited = !isFavorited;
                                });
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .addToWishlist(CartItem(
                                  id: product.id,
                                  title: product.title,
                                  description: product.description,
                                  imagePath: product.imagePath,
                                  price: product.price,
                                  hasDiscount: product.hasDiscount,
                                  discount: product.discount,
                                  quantity: product.quantity,
                                  category: product.category,
                                ));
                              } else {
                                // unfavorite it and remove
                                setState(() {
                                  isFavorited = !isFavorited;
                                });
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .removeFromWishlist(product.id);
                              }
                            }
                            // probaly init is favorited by a method that searches the wishlist
                          },
                          icon: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          )),
                    )
                  ],
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
                  backgroundColor: product.quantity > 0
                      ? const WidgetStatePropertyAll(Color(0xFF556B2F))
                      : const WidgetStatePropertyAll(
                          Color.fromARGB(255, 56, 58, 54)),
                  minimumSize:
                      WidgetStateProperty.all(Size(width * 0.7, height * 0.08)),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: product.quantity > 0
                    ? () {
                        // check if item already in cart
                        if (Provider.of<ProductProvider>(context, listen: false)
                            .cart
                            .any((element) => element.id == product.id)) {
                          showFailureDialog(
                              'Item already in cart. Increase quantity instead',
                              context);
                        } else {
                          // add to cart
                          Provider.of<ProductProvider>(context, listen: false)
                              .addToCart(CartItem(
                                  id: product.id,
                                  title: product.title,
                                  description: product.description,
                                  imagePath: product.imagePath,
                                  price: product.price,
                                  hasDiscount: product.hasDiscount,
                                  discount: product.discount,
                                  quantity: productQuantity,
                                  category: product.category));
                          showSuccesDialog('Item added successfully', context,
                              duration: 2);
                        }
                      }
                    : null,
                child:
                    Text(product.quantity > 0 ? 'Add to Cart' : 'Out of Stock'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
