import 'package:flutter/material.dart';
import 'package:furnishly/model/fakedata.dart';
import 'package:furnishly/views/shared.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(showSignInOut: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: faq.length,
                  itemBuilder: (context, index) {
                    final question = faq[index]["question"]!;
                    final answer = faq[index]["answer"]!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question,
                            style: TextStyle(
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontWeight,
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .color,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            answer,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall!
                                  .fontSize,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall!
                                  .color,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
