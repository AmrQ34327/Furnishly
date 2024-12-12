import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import 'shared.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool obscureText = true; // return it up if it doesnt work
    final width = MediaQuery.of(context).size.width;
    Account? currentUser = Provider.of<UserProvider>(context).currentUser;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    TextEditingController forgotPasswordController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(),
        // ternary condition for when signed in
        body: SafeArea(
          child: Center(
            child: _currentUser == null
                ? Padding(
                    padding: EdgeInsets.only(top: height * 0.06),
                    child: Form(
                      key: AccountPage.formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .fontWeight,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * 0.015),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                  validator: (val) {
                                    if (val == '') {
                                      return "Field can't be empty";
                                    }
                                    return null;
                                  },
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
                                StatefulBuilder(
                                    builder: (context, StateSetter setState) {
                                  return TextFormField(
                                      validator: (val) {
                                        if (val == '') {
                                          return "Field can't be empty";
                                        }
                                        return null;
                                      },
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
                                                : const Icon(
                                                    Icons.visibility_off),
                                          ),
                                          hintText: 'Enter your password',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: const OutlineInputBorder()));
                                }),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () {
                                        AwesomeDialog(
                                            context: context,
                                            dialogBackgroundColor:
                                                Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                            dialogType: DialogType.noHeader,
                                            animType: AnimType.rightSlide,
                                            body: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Enter Email",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyMedium!
                                                          .color,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .primaryTextTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                      fontSize:
                                                          Theme.of(context)
                                                              .primaryTextTheme
                                                              .bodyMedium!
                                                              .fontSize),
                                                ),
                                                SizedBox(
                                                    height: height * 0.006),
                                                TextField(
                                                  controller:
                                                      forgotPasswordController,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          hintText:
                                                              'Enter Email'),
                                                ),
                                                SizedBox(
                                                    height: height * 0.006),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      if (forgotPasswordController
                                                          .text.isNotEmpty) {
                                                        try {
                                                          await FirebaseAuth
                                                              .instance
                                                              .sendPasswordResetEmail(
                                                                  email:
                                                                      forgotPasswordController
                                                                          .text);
                                                          Navigator.pop(
                                                              context);
                                                          // show success message
                                                          showSuccesDialog(
                                                              'Password reset email sent',
                                                              context);
                                                        } on FirebaseAuthException catch (e) {
                                                          if (e.code ==
                                                              'invalid-email') {
                                                            showFailureDialog(
                                                                'Invalid Email',
                                                                context);
                                                          } else if (e.code ==
                                                              'user-not-found') {
                                                            showFailureDialog(
                                                                'User not found',
                                                                context);
                                                          } else {
                                                            showFailureDialog(
                                                                'Something went wrong',
                                                                context);
                                                          }
                                                        }
                                                      }
                                                    },
                                                    child:
                                                        const Text("Confirm"))
                                              ],
                                            )).show();
                                      },
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyMedium!
                                                .color),
                                      )),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (AccountPage.formKey.currentState!
                                          .validate()) {
                                        try {
                                          final credential = await FirebaseAuth
                                              .instance
                                              .signInWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                          Navigator.pushReplacementNamed(
                                              context, '/home');
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            showFailureDialog(
                                                'No User found for that Email',
                                                context);
                                          } else if (e.code ==
                                              'wrong-password') {
                                            showFailureDialog(
                                                'Wrong Password', context);
                                          } else {
                                            showFailureDialog(
                                                'Something went wrong',
                                                context);
                                          }
                                        }
                                      } else {
                                        // form not validated
                                        print("Form Not Validated");
                                      }
                                    },
                                    child: const Text(
                                      "Sign in",
                                    )),
                                SizedBox(height: height * 0.013),
                                Divider(
                                  thickness: 3.0,
                                  height: height * 0.030,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              // make the google sign in logic here
                              await signInWithGoogle();
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            icon: Image.asset(
                              'assets/googlelogo.png',
                              width: width * 0.060,
                              height: height * 0.060,
                            ),
                            label: const Text(
                              // Google sign in
                              "Sign in with Google",
                            ),
                          ),
                          SizedBox(height: height * 0.024),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    // use push replacment???
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: const Text(
                                    "Sign up",
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      // for testing purpose only
                      Text("Welcome ${currentUser?.username}"),
                      ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle!
                              .color,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color),
                        title: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color,
                            fontWeight: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontWeight,
                            fontSize: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                        onTap: () {
                          // here will take the user to edit account info
                          Navigator.pushNamed(context, '/editProfile');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.favorite,
                          color: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle!
                              .color,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color),
                        title: Text(
                          "Wishlist",
                          style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color,
                            fontWeight: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontWeight,
                            fontSize: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                        onTap: () {
                          // here will take the user to wishlist page
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.assignment,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color),
                        title: Text(
                          "My Orders",
                          style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color,
                            fontWeight: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontWeight,
                            fontSize: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                        onTap: () {
                          // here will take the user to my orders page
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color),
                        title: Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color,
                            fontWeight: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontWeight,
                            fontSize: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
        drawer: const MyDrawer());
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
