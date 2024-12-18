import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:furnishly/views/shared.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MyAppBar(showSignInOut: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: height * 0.06),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).primaryTextTheme.bodyLarge!.fontSize,
                    fontWeight: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .fontWeight,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.015),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Username",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .color,
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontWeight,
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize,
                            )),
                      ),
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your username',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: height * 0.017,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Email",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .color,
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontWeight,
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize,
                            )),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == '') {
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: height * 0.017,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Password",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .color,
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontWeight,
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize,
                            )),
                      ),
                      StatefulBuilder(builder: (context, StateSetter setState) {
                        return TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val == '') {
                                return "Field can't be empty";
                              }
                              if (val!.length < 8) {
                                return "Password must be at least 8 characters long";
                              }
                              if (!val.contains(RegExp(r'[A-Z]')) ||
                                  !val.contains(RegExp(r'[a-z]'))) {
                                return "Password must contain at least one uppercase letter, \n one number, \n and one special character";
                              }
                              if (!val.contains(RegExp(r'[0-9]'))) {
                                return "Password must contain at least one uppercase letter, \n one number, \n and one special character";
                              }
                              if (!val.contains(RegExp(
                                  r"""[!}{<>.,?\;:\'"`~@#$%^&*()_+\-=]"""))) {
                                return "Password must contain at least one uppercase letter, \n one number, \n and one special character";
                              }
                              return null;
                            },
                            controller: passwordController,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  icon: obscureText
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder()));
                      }),
                      SizedBox(height: height * 0.017),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Phone Number",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .color,
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontWeight,
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize,
                            )),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val == '') {
                            return "Field can't be empty";
                          }
                          if (val!.length > 15) {
                            return "Can't be more than 15 digits.";
                          }
                          if (val.contains(RegExp(r'[a-z]')) ||
                              val.contains(RegExp(r'[A-Z]'))) {
                            return "Can't contain letters";
                          }
                          return null;
                        },
                        controller: phoneController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your phone number',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: height * 0.017,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Address",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .color,
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontWeight,
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize,
                            )),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        validator: (val) {
                          if (val == '') {
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        controller: addressController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your address',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: height * 0.04),
                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                var currentProfile = Account(
                                  username: usernameController.text,
                                  email: emailController.text,
                                );
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setUser(currentProfile);
                                await FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification();
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setPassword(passwordController.text);
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setPhoneNumber(phoneController.text);
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .addAddress(addressController.text);
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showFailureDialog(
                                      'Password too weak', context);
                                } else if (e.code == 'email-already-in-use') {
                                  showFailureDialog(
                                      'Account already exists for that Email',
                                      context);
                                } else {
                                  showFailureDialog(
                                      'Something went wrong', context);
                                }
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              // Form Not validated
                            }
                          },
                          child: const Text(
                            "Sign Up",
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
