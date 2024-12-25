import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: "Account"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
      ],
      iconSize: width * 0.06,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/categories');
            break;
          case 2:
            Navigator.pushNamed(context, '/account');
            break;
          case 3:
            Navigator.pushNamed(context, '/cart');
            break;
        }
      },
    );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showSignInOut;

  MyAppBar({
    super.key,
    this.showSignInOut = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Text(
        "Furnishly",
        style: TextStyle(
          color: Theme.of(context).appBarTheme.titleTextStyle!.color,
          fontWeight: Theme.of(context).appBarTheme.titleTextStyle!.fontWeight,
          fontSize: Theme.of(context).appBarTheme.titleTextStyle!.fontSize,
        ),
      ),
      actions: [
        // takes you to account page and changed to first name
        // when signed in
        widget.showSignInOut
            ? TextButton(
                onPressed: () async {
                  FirebaseAuth.instance.currentUser == null
                      ? Navigator.pushNamed(context, '/account')
                      : await FirebaseAuth.instance.signOut();
                  setState(() {});
                },
                child: Text(
                  FirebaseAuth.instance.currentUser == null
                      ? "Sign in"
                      : "Sign Out",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                    fontSize: width * 0.036,
                  ),
                ))
            : const SizedBox(width: 0)
      ],
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width * 0.5,
        child: Drawer(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Furnishly",
                      style: GoogleFonts.cinzel(
                          color: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle!
                              .color,
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                  title: Text(
                    "Wishlist",
                    style: TextStyle(
                      color:
                          Theme.of(context).appBarTheme.titleTextStyle!.color,
                    ),
                  ),
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/wishlist');
                    } else {
                      Navigator.pushNamed(context, '/account');
                    }
                  }),
              ListTile(
                leading: Icon(Icons.assignment,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
                title: Text(
                  "My Orders",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  // here will take the user to my orders page
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/myOrders');
                  } else {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/account');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.phone,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contactUsPage');
                },
              ),
              ListTile(
                leading: Icon(Icons.help,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
                title: Text(
                  "FAQ",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/faq');
                },
              ),
              // a sign out that appears if signed in
              const ListTile(),
            ],
          ),
        ));
  }
}

class EditInfoWidget extends StatelessWidget {
  final String textTitle;
  final String textInField;
  final TextEditingController? mainController;
  final TextEditingController dialogController;
  final String dialogTitle;
  final String dialogHintText;
  final VoidCallback confirmButtonFunction;
  final bool showEmailVerificationStatus;
  final bool isPasswordDialog;
  final GlobalKey<FormState>? formKey;
  final GlobalKey<FormState>? originalFormKey;
  final String? fieldType;

  const EditInfoWidget(
      {super.key,
      required this.textTitle,
      this.fieldType,
      required this.textInField,
      required this.dialogTitle,
      required this.dialogHintText,
      this.mainController,
      required this.confirmButtonFunction,
      this.showEmailVerificationStatus = false,
      this.isPasswordDialog = false,
      this.formKey,
      this.originalFormKey,
      required this.dialogController});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool obscureText = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            textTitle,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
        SizedBox(height: height * 0.016),
        ListTile(
            leading: SizedBox(
              width: width * 0.6,
              child: TextField(
                obscureText: isPasswordDialog,
                enabled: false,
                controller: mainController,
                decoration: InputDecoration(
                    fillColor: const Color.fromARGB(132, 75, 73, 73),
                    filled: true,
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.black),
                    hintText: textInField),
              ),
            ),
            trailing: SizedBox(
              width: width * 0.11,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ElevatedButton(
                  onPressed: () {
                    // show dialog here
                    AwesomeDialog(
                            context: context,
                            dialogBackgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.rightSlide,
                            body: !isPasswordDialog
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dialogTitle,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium,
                                      ),
                                      SizedBox(height: height * 0.006),
                                      Form(
                                        key: originalFormKey,
                                        child: TextFormField(
                                          maxLines: null,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (val) {
                                            if (val == '') {
                                              return "Field can't be empty";
                                            }
                                            if (fieldType == 'phone') {
                                              if (val == '') {
                                                return "Field can't be empty";
                                              }
                                              if (val!.length > 15) {
                                                return "Can't be more than 15 digits.";
                                              }
                                              if (val.contains(
                                                      RegExp(r'[a-z]')) ||
                                                  val.contains(
                                                      RegExp(r'[A-Z]'))) {
                                                return "Can't contain letters";
                                              }
                                            }

                                            return null;
                                          },
                                          keyboardType: fieldType == 'email'
                                              ? TextInputType.emailAddress
                                              : fieldType == 'phone'
                                                  ? TextInputType.phone
                                                  : fieldType == 'address'
                                                      ? TextInputType
                                                          .streetAddress
                                                      : TextInputType.text,
                                          controller: dialogController,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              hintText: dialogHintText),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.006),
                                      ElevatedButton(
                                          onPressed: confirmButtonFunction,
                                          child: const Text("Confirm"))
                                    ],
                                  )
                                :
                                // a password dialog
                                Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Text(
                                          dialogTitle,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyMedium,
                                        ),
                                        SizedBox(height: height * 0.006),
                                        StatefulBuilder(builder:
                                            (context, StateSetter setState) {
                                          return TextFormField(
                                            obscureText: obscureText,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (val) {
                                              if (val == '') {
                                                return "Field can't be empty";
                                              }
                                              if (val!.length < 8) {
                                                return "Password must be at least 8 characters long";
                                              }
                                              if (!val.contains(
                                                      RegExp(r'[A-Z]')) ||
                                                  !val.contains(
                                                      RegExp(r'[a-z]'))) {
                                                return "Password must contain at least one uppercase letter, \n one number, \n and one special character";
                                              }
                                              if (!val
                                                  .contains(RegExp(r'[0-9]'))) {
                                                return "Password must contain at least one uppercase letter, \n one number, \n and one special character";
                                              }
                                              if (!val.contains(RegExp(
                                                  r"""[!}{<>.,?\;:\'"`~@#$%^&*()_+\-=]"""))) {
                                                return "Password must contain at least one uppercase letter, \n one number, \n and one special character";
                                              }
                                              return null;
                                            },
                                            controller: dialogController,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      obscureText =
                                                          !obscureText;
                                                    });
                                                  },
                                                  icon: obscureText
                                                      ? const Icon(
                                                          Icons.visibility)
                                                      : const Icon(
                                                          Icons.visibility_off),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                hintText: dialogHintText),
                                          );
                                        }),
                                        SizedBox(height: height * 0.006),
                                        ElevatedButton(
                                            onPressed: confirmButtonFunction,
                                            child: const Text("Confirm"))
                                      ],
                                    )))
                        .show();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(width * 0.004),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Center(child: Icon(Icons.edit)),
                ),
              ),
            )),
        showEmailVerificationStatus
            ? SizedBox(height: height * 0.006)
            : const SizedBox(),
        showEmailVerificationStatus
            ? Padding(
                padding: EdgeInsets.only(right: width * 0.5),
                child: Text(
                  FirebaseAuth.instance.currentUser!.emailVerified
                      ? ''
                      : 'Email not verified',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 175, 15, 3)),
                ),
              )
            : const SizedBox(),
        // add any new widget here
        SizedBox(height: height * 0.026),
      ],
    );
  }
}

void showSuccesDialog(String message, BuildContext context,
    {int duration = 3}) {
  AwesomeDialog(
          context: context,
          dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: message,
          titleTextStyle: Theme.of(context).primaryTextTheme.bodyMedium,
          descTextStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
            fontWeight:
                Theme.of(context).primaryTextTheme.bodyMedium!.fontWeight,
            fontSize: Theme.of(context).primaryTextTheme.bodySmall!.fontSize,
          ),
          autoHide: Duration(seconds: duration))
      .show();
}

void showFailureDialog(String message, BuildContext context) {
  AwesomeDialog(
          context: context,
          dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: message,
          titleTextStyle: Theme.of(context).primaryTextTheme.bodyMedium,
          descTextStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
            fontWeight:
                Theme.of(context).primaryTextTheme.bodyMedium!.fontWeight,
            fontSize: Theme.of(context).primaryTextTheme.bodySmall!.fontSize,
          ),
          autoHide: const Duration(seconds: 3))
      .show();
}

class MyImageContainer extends StatelessWidget {
  final Widget child;
  const MyImageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.03), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Light shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow direction
          ),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(width * 0.03), child: child),
    );
  }
}

class CheckOutInfoWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController fieldController;
  final String? Function(String?)? validator;
  final bool isPhoneField;
  final bool isAddressField;

  const CheckOutInfoWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.fieldController,
      this.isPhoneField = false,
      this.isAddressField = false,
      this.validator});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).primaryTextTheme.bodyMedium),
          SizedBox(height: height * 0.01),
          TextFormField(
              keyboardType: isPhoneField
                  ? TextInputType.phone
                  : isAddressField
                      ? TextInputType.streetAddress
                      : TextInputType.text,
              validator: validator,
              controller: fieldController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: hintText)),
          SizedBox(height: height * 0.01)
        ]);
  }
}
