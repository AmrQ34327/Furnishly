import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:furnishly/model/model.dart';
import 'package:furnishly/views/shared.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 13),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'My Cart',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .fontWeight,
                          color: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle!
                              .color,
                        ),
                      ),
                    ),
                  ),
                ),
                context.read<ProductProvider>().isCartEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.3),
                        child: Center(
                            child: Text(
                          'Your cart is empty',
                          style : Theme.of(context).primaryTextTheme.bodyMedium,
                        )),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount:
                                context.watch<ProductProvider>().cart.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final product =
                                  Provider.of<ProductProvider>(context)
                                      .cart[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CartTile2(
                                  cartItem: product,
                                  productQuantity: product.quantity,
                                ),
                              );
                            }),
                      ),
                // new widgets here
                Provider.of<ProductProvider>(context).isCartEmpty
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount: ',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .fontSize,
                                    fontWeight: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .fontWeight,
                                  ),
                                ),
                                Text(
                                  '- ${Provider.of<ProductProvider>(context, listen: false).totalDiscount.toStringAsFixed(2)} ',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .fontSize,
                                    fontWeight: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .fontWeight,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total: ',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .fontSize,
                                    fontWeight: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .fontWeight,
                                  ),
                                ),
                                Text(
                                  '\$ ${Provider.of<ProductProvider>(context, listen: false).totalPrice.toStringAsFixed(2)} ',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .fontSize,
                                    fontWeight: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .fontWeight,
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  // open a checkout window
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    Navigator.pushNamed(context, '/checkout');
                                  } else {
                                    showFailureDialog('Not Signed in', context);
                                  }
                                },
                                child: Text("Proceed to checkout"))
                          ],
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

class CartTile2 extends StatefulWidget {
  final CartItem cartItem;
  int productQuantity;
  final bool showIncreaseDecreaseQuantity;

  CartTile2(
      {super.key,
      required this.cartItem,
      required this.productQuantity,
      this.showIncreaseDecreaseQuantity = true});

  @override
  State<CartTile2> createState() => _CartTileState2();
}

class _CartTileState2 extends State<CartTile2> {
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = widget.cartItem.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // increase decrease quantity column
          widget.showIncreaseDecreaseQuantity
              ? SizedBox(
                  width: 40,
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 18,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .color,
                        onPressed: () {
                          setState(() {
                            widget.productQuantity++;
                            quantityController.text =
                                widget.productQuantity.toString();
                            Provider.of<ProductProvider>(context, listen: false)
                                .updateQuantity(
                                    widget.cartItem, widget.productQuantity);
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                      SizedBox(
                        width: widget.productQuantity > 9 ? 25 : 17,
                        height: 17,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5), // make it adaptive
                            fillColor: Color.fromARGB(255, 6, 68, 119),
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 18,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .color,
                        onPressed: () {
                          setState(() {
                            if (widget.productQuantity > 1) {
                              widget.productQuantity--;
                              quantityController.text =
                                  widget.productQuantity.toString();
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .updateQuantity(
                                      widget.cartItem, widget.productQuantity);
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  width: 12,
                ),
          // image
          SizedBox(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.0),
              child: Image.asset(
                widget.cartItem.imagePath,
                width: 40,
                height: 70,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 12),
          // column for title subtutle
          Expanded(
            child: SizedBox(
              width: 220,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.cartItem.title,
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.039,
                        ),
                      )),
                  SizedBox(height: 9),
                  Text(
                    widget.cartItem.description,
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall!.color,
                      fontSize: width * 0.031,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ),
          // column for x and price
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 17.0),
                child: IconButton(
                    iconSize: 18,
                    color: Theme.of(context).primaryTextTheme.bodySmall!.color,
                    onPressed: () {
                      if (widget.showIncreaseDecreaseQuantity) {
                        // delete entry from cart
                        Provider.of<ProductProvider>(context, listen: false)
                            .removeFromCart(widget.cartItem.id);
                        setState(() {});
                      } else {
                        // remove entry from wishlist
                        Provider.of<UserProvider>(context, listen: false)
                            .removeFromWishlist(widget.cartItem.id);
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.close)),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                '\$' + widget.cartItem.price.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.030),
              )
            ],
          ),
          SizedBox(
            width: 11,
          )
        ],
      ),
    );
  }
}
