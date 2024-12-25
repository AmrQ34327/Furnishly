import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furnishly/model/model.dart';
import 'package:furnishly/views/shared.dart';


class ContactUsPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
     
    return Scaffold(
      appBar: MyAppBar(
        showSignInOut: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get in Touch",
                  style : Theme.of(context).primaryTextTheme.bodyLarge,
                ),
                SizedBox(height: height * 0.022),
                // Phone Card
                Card(
                  child: ListTile(
                    leading: Icon(Icons.phone,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      "Call us at: +1-234-567-8900",
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      makePhoneCall('+12345678900');
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                // Email Card
                Card(
                  child: ListTile(
                    leading: Icon(Icons.email,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      "Email us at: support@furnishly.com",
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      sendEmail('support@furnishly.com');
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                // Address Card
                Card(
                  child: ListTile(
                    leading: Icon(Icons.location_on,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      "123 Furnishly Lane, Home City, Country",
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                // Inquiry Form
                Text(
                  "Quick Inquiry",
                  style : Theme.of(context).primaryTextTheme.bodyLarge,
                ),
                SizedBox(height: height * 0.021),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                ),
                SizedBox(height: height * 0.01),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
                SizedBox(height: height * 0.01),
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      labelText: 'Message', border: OutlineInputBorder()),
                ),
                SizedBox(height: height * 0.021),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        messageController.text.isNotEmpty) {
                      sendInquiryEmail(nameController.text,
                          emailController.text, messageController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: const Color(0xFF556B2F),
                            content: Text('Your message has been sent!',
                                style: TextStyle(color: Colors.white))),
                      );
                      nameController.clear();
                      emailController.clear();
                      messageController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: const Color.fromARGB(255, 88, 4, 4),
                          content: Text(
                            'Complete all fields to send an inquiry',
                            style: TextStyle(color: Colors.white),
                          )));
                    }
                  },
                  child: Text('Send Inquiry'),
                ),
                SizedBox(height: height * 0.023),
                // Social Media Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () {
                        openFacebook();
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.instagram, color: Color.fromARGB(255, 228, 64, 95) 
 ,),
                      onPressed: () {
                        // Open Instagram link
                        openInstagram();
                      },
                    ),
                    IconButton(
                      icon:  Icon(
                        FontAwesomeIcons.x,size: width * 0.05,
                      ),
                      onPressed: () {
                        openX();
                      },
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: Text(
                    "Our team will get back to you within 24-48 hours. Thank you for reaching out!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
