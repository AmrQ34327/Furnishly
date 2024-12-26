import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/model/model.dart';
import 'package:furnishly/views/shared.dart';
import 'package:provider/provider.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final orderList = Provider.of<UserProvider>(context).orderList;
    // Sort the orderList by orderMadeDate (newest to oldest)
    orderList
        .sort((Order a, Order b) => b.orderMadeDate.compareTo(a.orderMadeDate));
    return Scaffold(
      appBar: MyAppBar(showSignInOut: false),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(height * 0.025),
        child: Column(
          children: [
            // here
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
                    'My Orders',
                    style: TextStyle(
                      fontSize: width * 0.075,
                      fontWeight: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .fontWeight,
                      color:
                          Theme.of(context).appBarTheme.titleTextStyle!.color,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.012),
            Provider.of<UserProvider>(context, listen: false)
                    .currentUser!
                    .orderList
                    .isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount:
                            context.watch<UserProvider>().orderList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final order = Provider.of<UserProvider>(context)
                              .orderList[index];
                          return Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: OrderCard(
                              name: order.name,
                              address: order.address,
                              date: order.date,
                              orderNumber: order.orderNumber,
                              phoneNumber: order.phoneNumber,
                              total: order.total,
                              paymentMethod: order.paymentMethod,
                              orderedItems: order.orderedItems,
                            ),
                          );
                        }),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: height * 0.3),
                    child: Text(
                      'No past orders',
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String name;
  final String address;
  final String date;
  final String orderNumber;
  final String phoneNumber;
  final String total;
  final String paymentMethod;
  final List<dynamic> orderedItems;

  const OrderCard(
      {super.key,
      required this.name,
      required this.address,
      required this.date,
      required this.orderNumber,
      required this.phoneNumber,
      required this.total,
      required this.paymentMethod,
      required this.orderedItems});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(width * 0.015),
        child: Column(
          children: [
            // name row
            Row(
              children: [
                const Icon(Icons.person_2_rounded),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    titleCase(name),
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall!.color,
                      fontSize: Theme.of(context)
                          .primaryTextTheme
                          .bodyMedium!
                          .fontSize,
                      fontWeight: Theme.of(context)
                          .primaryTextTheme
                          .bodySmall!
                          .fontWeight,
                    ),
                  ),
                ),
              ],
            ),
            // address row
            Row(
              children: [
                Icon(Icons.apartment_rounded),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    titleCase(address),
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall!.color,
                      fontSize: Theme.of(context)
                          .primaryTextTheme
                          .bodyMedium!
                          .fontSize,
                      fontWeight: Theme.of(context)
                          .primaryTextTheme
                          .bodySmall!
                          .fontWeight,
                    ),
                  ),
                )
              ],
            ),
            // date row
            Row(
              children: [
                Icon(Icons.calendar_today_rounded),
                SizedBox(
                  width: 6,
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodySmall!.color,
                    fontSize:
                        Theme.of(context).primaryTextTheme.bodyMedium!.fontSize,
                    fontWeight: Theme.of(context)
                        .primaryTextTheme
                        .bodySmall!
                        .fontWeight,
                  ),
                )
              ],
            ),
            // the view order details here inkwell
            InkWell(
              onTap: () {
                // open order details page
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.rightSlide,
                  body: Column(
                    children: [
                      // order info widget
                      OrderInfo(title: 'Order Number', subtitle: orderNumber),
                      OrderInfo(
                          title: 'Recipient Name', subtitle: titleCase(name)),
                      OrderInfo(title: 'Phone Number', subtitle: phoneNumber),
                      OrderInfo(title: 'Delivery Address', subtitle: address),
                      OrderInfo(title: 'Delivery Date', subtitle: date),
                      OrderInfo(
                          title: 'Payment Method', subtitle: paymentMethod),
                      Text('Ordered Items',
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
                          )),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderedItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final orderedItem = orderedItems[index];
                            return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // item quantatiy
                                    Text(
                                      '${orderedItem.quantity.toString()} x',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    // item title
                                    Text(
                                      orderedItem.title,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall,
                                    )
                                  ],
                                ));
                          }),
                      SizedBox(height: 10),
                      Text('Total',
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
                                .bodySmall!
                                .fontWeight,
                          )),
                      Text(total,
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
                                .bodySmall!
                                .fontWeight,
                          )),
                    ],
                  ),
                  btnOkOnPress: () {},
                ).show();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Show Order Details',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall!.color,
                      fontSize: Theme.of(context)
                          .primaryTextTheme
                          .bodySmall!
                          .fontSize,
                      fontWeight: Theme.of(context)
                          .primaryTextTheme
                          .bodySmall!
                          .fontWeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  const OrderInfo({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // tttt
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodySmall!.color,
            fontSize: Theme.of(context).primaryTextTheme.bodyMedium!.fontSize,
            fontWeight:
                Theme.of(context).primaryTextTheme.bodyMedium!.fontWeight,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          subtitle,
          style: Theme.of(context).primaryTextTheme.bodySmall,
        ),
        SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

String titleCase(String input) {
  return input
      .toLowerCase()
      .split(' ')
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1)
          : '') // Capitalize the first letter of each word
      .join(' ');
}
