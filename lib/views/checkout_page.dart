import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/model/model.dart';
import 'package:furnishly/views/shared.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController promoCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final int shippingFees = 10;
  double promoCode = 0;
  DateTime threeDaysAfterTodayDate =
      DateTime.now().add(const Duration(days: 3));

  String selectedDeliveryDate = 'Soon as possible';
  String? userChosenDate;
  final TextEditingController dateController =
      TextEditingController(); // userChosenDate

  String paymentMethod = 'Cash on delivery';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_isInitialized) {
      final Account? currentUser =
          Provider.of<UserProvider>(context).currentUser;
      nameController.text = currentUser!.username;
      addressController.text = currentUser.mainAddress;
      phoneController.text = currentUser.phoneNumber;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Account? currentUser = Provider.of<UserProvider>(context).currentUser;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    DateTime soonAsPossibleDate = DateTime(threeDaysAfterTodayDate.year,
        threeDaysAfterTodayDate.month, threeDaysAfterTodayDate.day);
    return Scaffold(
      appBar: MyAppBar(showSignInOut: false),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(width * 0.045),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckOutInfoWidget(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Must provide a name';
                      }
                      return null;
                    },
                    title: 'Recipient Name',
                    hintText: 'Enter Your Name',
                    fieldController: nameController),
                CheckOutInfoWidget(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Must provide an address';
                      }
                      return null;
                    },
                    title: 'Address',
                    hintText: 'Enter Your Address',
                    isAddressField: true,
                    fieldController: addressController),
                CheckOutInfoWidget(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Must provide a phone number';
                      }
                      if (val.length > 15) {
                        return "Can't be more than 15 digits.";
                      }
                      if (val.contains(RegExp(r'[a-z]')) ||
                          val.contains(RegExp(r'[A-Z]'))) {
                        return "Can't contain letters";
                      }
                      return null;
                    },
                    title: 'Phone Number',
                    isPhoneField: true,
                    hintText: 'Enter Your Phone Number',
                    fieldController: phoneController),
                // deleviry time part
                Text('Delivery Date',
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
                RadioListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                    title: Text('Soon as possible',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color,
                        )),
                    value: 'Soon as possible',
                    groupValue: selectedDeliveryDate,
                    onChanged: (val) {
                      setState(
                        () {
                          selectedDeliveryDate = val!;
                          userChosenDate = null;
                        },
                      );
                    }),
                RadioListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                    title: Text('Pick date',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color,
                        )),
                    value: 'Pick date',
                    groupValue: selectedDeliveryDate,
                    onChanged: (val) async {
                      setState(() {
                        selectedDeliveryDate = val!;
                      });
                      if (selectedDeliveryDate != 'Soon as possible') {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate:
                              DateTime.now().add(const Duration(days: 3)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 18)),
                        );

                        if (pickedDate != null) {
                          DateTime dateOnly = DateTime(pickedDate.year,
                              pickedDate.month, pickedDate.day);
                          userChosenDate =
                              dateOnly.toLocal().toString().split(' ')[0];
                          dateController.text = userChosenDate!;
                        }
                      }
                    }),
                userChosenDate != null
                    ? TextField(
                        readOnly: true,
                        controller: dateController,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 8,
                ),
                Text('Payment Method',
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
                RadioListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                    title: Text('Cash on Delivery',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color,
                        )),
                    value: 'Cash on delivery',
                    groupValue: paymentMethod,
                    onChanged: (val) {
                      setState(
                        () {
                          paymentMethod = val!;
                        },
                      );
                    }),
                RadioListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                    title: Text('Credit/Debit Card',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color,
                        )),
                    value: 'Credit card',
                    groupValue: paymentMethod,
                    onChanged: (val) {
                      setState(
                        () {
                          paymentMethod = val!;
                          AwesomeDialog(
                                  context: context,
                                  dialogBackgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  descTextStyle: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall!
                                          .color),
                                  title: '',
                                  desc:
                                      'Real card payment integration is not implemented due to the need for business verification, Your order will be accepted once you click Confirm Order',
                                  autoHide: const Duration(seconds: 5))
                              .show();
                        },
                      );
                    }),
                Text('Promo Code',
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
                Text(
                  'Click the checkmark to apply the promo code',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 94, 88, 88),
                    fontSize: width * 0.03,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: promoCodeController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          // validate promo code
                          if (promoCodeController.text.isNotEmpty) {
                            if (promoCodes.containsKey(
                                promoCodeController.text.toUpperCase())) {
                              setState(() {
                                promoCode = promoCode +
                                    promoCodes[promoCodeController.text
                                        .toUpperCase()]!;
                                showSuccesDialog('Promo code applied', context,
                                    duration: 2);
                              });
                            } else {
                              showFailureDialog('Invalid Promo Code', context);
                            }
                          }
                        },
                        icon: const Icon(Icons.check)),
                    hintText: 'Add Promo Code',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal: ',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                      '\$ ${Provider.of<ProductProvider>(context, listen: false).subtotal.toStringAsFixed(2)} ',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                      'Discount: ',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                // promo codes if any
                promoCode > 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Promo Code: ',
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
                            '- ${promoCode.toStringAsFixed(2)} ',
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
                      )
                    : const SizedBox(),
                // shipping fees
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping Fees: ',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                      '\$ $shippingFees ',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                      '\$ ${(Provider.of<ProductProvider>(context, listen: false).totalPrice + shippingFees - promoCode).toStringAsFixed(2)} ',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodySmall!.color,
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
                SizedBox(height: height * 0.02),
                Align(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // do the cash on delivery part
                          if (paymentMethod == 'Cash on delivery' ||
                              paymentMethod == 'Credit card') {
                            // 1 - add to orders list
                            var uuid = Uuid();
                            Provider.of<UserProvider>(context, listen: false)
                                .makeOrder(Order(
                              orderMadeDate: DateTime.now(),
                              orderNumber: uuid.v4(),
                              deliveryDate:
                                  selectedDeliveryDate == 'Soon as possible'
                                      ? soonAsPossibleDate
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0]
                                      : (userChosenDate ??
                                          soonAsPossibleDate
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0]),
                              orderedItems: Provider.of<ProductProvider>(
                                      context,
                                      listen: false)
                                  .cart
                                  .toList(),
                              paymentMethod: paymentMethod,
                              totalPrice: Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .totalPrice +
                                  shippingFees -
                                  promoCode,
                              deliveryAdress: addressController.text,
                              name: nameController.text,
                              phoneNumber: phoneController.text,
                            ));
                            // 2 - decrease quantity in stock
                            Provider.of<ProductProvider>(context, listen: false)
                                .decreaseOrderQuantity(
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .cart,
                                    productList);
                            // 3 - clear cart
                            Provider.of<ProductProvider>(context, listen: false)
                                .clearCart();
                            // navigate to my orders page when i make it
                            //Navigator.pushNamed(context, '/orders');
                            Navigator.pushNamed(context, '/home');
                          }
                          // do the credit card here
                        }
                      },
                      child: const Text('Confirm Order')),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
