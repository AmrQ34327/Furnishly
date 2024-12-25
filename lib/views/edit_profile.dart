import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/controller/controller.dart';
import 'package:furnishly/views/my_orders.dart';
import 'package:furnishly/views/shared.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';

class EditAccountPage extends StatelessWidget {
  EditAccountPage({super.key});
  final TextEditingController emaildialogController = TextEditingController();
  final TextEditingController usernameDialogController =
      TextEditingController();
  final TextEditingController passwordDialogController =
      TextEditingController();
  final TextEditingController phoneDialogController = TextEditingController();
  final TextEditingController addressDialogController = TextEditingController();
  final GlobalKey<FormState>? formKey = GlobalKey();
  final GlobalKey<FormState>? formKey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Account? currentUser = Provider.of<UserProvider>(context).currentUser;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TextEditingController passwordController =
        TextEditingController(text: currentUser!.password);
    return Scaffold(
      appBar: MyAppBar(
        showSignInOut: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // the username
                EditInfoWidget(
                    originalFormKey: formKey2,
                    textTitle: "Name",
                    textInField: currentUser.username,
                    dialogTitle: "Enter New Name",
                    dialogHintText: 'Enter New Name',
                    confirmButtonFunction: () {
                      if (formKey2!.currentState!.validate()) {
                        if (usernameDialogController.text.isNotEmpty) {
                          Provider.of<UserProvider>(context, listen: false)
                              .updateUsername(titleCase(usernameDialogController.text));
                          usernameDialogController.clear();
                          Navigator.pop(context);
                          //show success dialog ???
                        }
                      }
                    },
                    dialogController: usernameDialogController),
                // the email
                EditInfoWidget(
                    originalFormKey: formKey2,
                    fieldType: 'email',
                    textTitle: "Email",
                    showEmailVerificationStatus: true,
                    // change below to !
                    textInField: currentUser.email ,
                    dialogTitle: "Enter New Email",
                    dialogHintText: "Enter New Email",
                    confirmButtonFunction: () async {
                      if (formKey2!.currentState!.validate()) {
                        if (emaildialogController.text.isNotEmpty) {
                          try {
                            await FirebaseAuth.instance.currentUser!
                                .verifyBeforeUpdateEmail(
                                    emaildialogController.text);
                            emaildialogController.clear();
                            Navigator.pop(context);
                            // show succesful dialog check inbox for verefication
                            showSuccesDialog(
                                "Please check your inbox for a verification email to complete the process",
                                context, duration: 4);
                          } on FirebaseAuthException catch (e) {
                            // can enhance it & make it reauthentica user
                            if (e.code == 'requires-recent-login') {
                              showFailureDialog(
                                  'Requires recent login', context);
                            } else if (e.code == 'email-already-in-use') {
                              showFailureDialog(
                                  'Email already in use', context);
                            } else {
                              showFailureDialog('An Error Occured', context);
                            }
                          }
                        }
                      }
                    },
                    dialogController: emaildialogController),
                // the password
                EditInfoWidget(
                    formKey: formKey,
                    isPasswordDialog: true,
                    textTitle: 'Password',
                    textInField: passwordController.text,
                    dialogTitle: "Enter new password",
                    dialogHintText: 'Enter new password',
                    mainController: passwordController,
                    confirmButtonFunction: () async {
                      if (formKey!.currentState!.validate()) {
                        if (passwordDialogController.text.isNotEmpty) {
                          try {
                            await FirebaseAuth.instance.currentUser!
                                .updatePassword(passwordDialogController.text);
                            Provider.of<UserProvider>(context, listen: false)
                                .setPassword(passwordDialogController.text);
                            Navigator.pop(context);
                            showSuccesDialog("Password Updated", context);
                            passwordDialogController.clear();
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'requires-recent-login') {
                              showFailureDialog(
                                  'Requires recent login', context);
                            } else if (e.code == 'weak-password') {
                              showFailureDialog(
                                  'Password is too weak', context);
                            } else {
                              showFailureDialog('An Error Occured', context);
                            }
                          }
                        }
                      }
                    },
                    dialogController: passwordDialogController),
                // phone number
                EditInfoWidget(
                    fieldType: 'phone',
                    originalFormKey: formKey2,
                    textTitle: 'Phone Number',
                    textInField: currentUser.phoneNumber,
                    dialogTitle: 'Enter New Phone Number',
                    dialogHintText: 'Enter New Phone number',
                    confirmButtonFunction: () {
                      if (formKey2!.currentState!.validate()) {
                        if (phoneDialogController.text.isNotEmpty) {
                          Provider.of<UserProvider>(context, listen: false)
                              .setPhoneNumber(phoneDialogController.text);
                          phoneDialogController.clear();
                          Navigator.pop(context);
                          showSuccesDialog(
                              'Phone Number Changed Successfully', context);
                        }
                      } else {
                        print('Validation Failed - Debugging');
                      }
                    },
                    dialogController: phoneDialogController),
                // the address
                EditInfoWidget(
                    originalFormKey: formKey2,
                    fieldType: 'address',
                    textTitle: "Address",
                    textInField: currentUser.mainAddress,
                    dialogTitle: 'Enter New Address',
                    dialogHintText: 'Enter New Address',
                    confirmButtonFunction: () {
                      if (formKey2!.currentState!.validate()) {
                        if (addressDialogController.text.isNotEmpty) {
                          Provider.of<UserProvider>(context, listen: false)
                              .addAddress(addressDialogController.text);
                          addressDialogController.clear();
                          Navigator.pop(context);
                          showSuccesDialog(
                              'Your address has been successfully updated',
                              context);
                        }
                      }
                    },
                    dialogController: addressDialogController)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
