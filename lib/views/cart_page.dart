import 'package:awesome_dialog/awesome_dialog.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(width * 0.025),
            child: Column(
              children: <Widget>[
                SizedBox(height: height * 0.017),
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
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Text(
                        'My Cart',
                        style: TextStyle(
                          fontSize: width * 0.075,
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
                          style: Theme.of(context).primaryTextTheme.bodyMedium,
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
                                padding: EdgeInsets.all(width * 0.01),
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
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
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
                                  var outOfStockProducts =
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .outOfStockProducts().toList();
                                  if (outOfStockProducts.isEmpty){
                                     if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    Navigator.pushNamed(context, '/checkout');
                                  } else {
                                    showFailureDialog('Not Signed in', context);
                                  }
                                  } else {
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.noHeader,
                                              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                              animType: AnimType.rightSlide,
                                              title: 'Stock Limit Exceeded',
                                              titleTextStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                                              descTextStyle: Theme.of(context).primaryTextTheme.bodySmall,
                                              desc: int.parse(outOfStockProducts[1]) > 1 ?  'We are sorry! We currently only have ${outOfStockProducts[1]}x ${outOfStockProducts[0]} in stock. Please reduce the quantity in your cart to proceed. Thank you' :  'We are sorry!  ${outOfStockProducts[0]} is currently out of stock.',
                                              btnOkOnPress: () {},
                                              autoHide: const Duration(seconds: 5),
                                              ).show();
                                  }
                                 
                                },
                                child: const Text("Proceed to checkout"))
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
    final height = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.050),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // increase decrease quantity column
          widget.showIncreaseDecreaseQuantity
              ? SizedBox(
                  width: width * 0.12,
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: width * 0.05,
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
                        width: widget.productQuantity > 9
                            ? width * 0.06
                            : width * 0.044,
                        height: height * 0.03,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.03,
                          ),
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: width * 0.012), // make it adaptive
                            fillColor: Color.fromARGB(255, 6, 68, 119),
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: width * 0.05,
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
            height: height * 0.105,
            width: width * 0.19,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.05),
              child: Image.asset(
                widget.cartItem.imagePath,
                width: width * 0.06,
                height: height * 0.0525,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: width * 0.03),
          // column for title subtutle
          Expanded(
            child: SizedBox(
              width: width * 0.5,
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
                  SizedBox(height: height * 0.01),
                  Text(
                    widget.cartItem.description,
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall!.color,
                      fontSize: width * 0.031,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          // column for x and price
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: IconButton(
                    iconSize: width * 0.05,
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
                height: height * 0.02,
              ),
              Text(
                '\$' + widget.cartItem.price.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.030),
              )
            ],
          ),
          SizedBox(
            width: width * 0.03,
          )
        ],
      ),
    );
  }
}
