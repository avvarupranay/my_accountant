// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../App Bloc/app_auth_bloc.dart';
import '../../App Widgets/password_input.dart';
import '../../Global/app_regex.dart';
import '../../Global/common_utils.dart';
import '../../Global/global_routes/App Routes/app_routes.dart';
import '../../Global/global_routes/app_base_screen.dart';
import '../../Loading Bloc/loading_bloc.dart';

// ignore: must_be_immutable
class UserRegisterScreen extends MyAccountantScreen {
  UserRegisterScreen({super.key});
  bool validate() {
    if (validateEmail && validatePassword) {
      return true;
    }
    return false;
  }

  bool get validateEmail => emailTextController.text.isNotEmpty;

  bool get validatePassword =>
      (passwordTextController.text == confirmPasswordTextController.text) &&
      (passwordTextController.text.isNotEmpty ||
          confirmPasswordTextController.text.isNotEmpty);
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void register(BuildContext context) async {
    try {
      if (registerPageKey.currentState!.validate()) {
        if (validate()) {
          startProgress();
          await appBloc.registerUser(emailTextController.text, passwordTextController.text);
          clearForAppOrScreen();
          dismissProgress();
          print('Register-successfull user logged in');
        } else {
          showErrorDialog(context, registerError,
              "Please confirm your credentials properly");
        }
      } else {
        showErrorDialog(
            context, registerError, "Please provide valid credentials");
      }
    } on FirebaseAuthException catch (e) {
      dismissProgress();
      showErrorDialog(context, registerError, e.message);
    }
  }

  void backToLogin(BuildContext context) {
    Navigator.of(context).pop();
  }

  final registerPageKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<AppBloc, AppAuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            dismissProgress();
            Navigator.pushNamedAndRemoveUntil(
                context, MyAccountantRouter.home, (route) => false);
          }
        },
        child: Center(
          child: Form(
            key: registerPageKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: SizedBox(
                    width: lengthOfTextFormField(context),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be left empty";
                        }
                      },
                      controller: emailTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            ValidateHelper.alphanumericWithEmailAcceptance)),
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter your Email Address',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: PasswordInput(
                      passwordTextController: passwordTextController,
                      validationMessage: "Password cannot be left empty",
                      hintText: 'Enter your Password'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: PasswordInput(
                      passwordTextController: confirmPasswordTextController,
                      validationMessage: "Reconfirm you Password please",
                      hintText: 'Confirm your Password'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: SizedBox(
                      width: lengthOfSubmitButton(context),
                      height: heightOfSubmitButton(context),
                      child: ElevatedButton(
                          onPressed: () {
                            register(context);
                          },
                          child: const Text('Submit'))),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(10),
                  child: SizedBox(
                      width: lengthOfSubmitButton(context),
                      height: heightOfSubmitButton(context),
                      child: InkWell(
                          onTap: () {
                            backToLogin(context);
                          },
                          child: const Center(
                              child: Text('Already a User? LogIn',
                                  style: TextStyle(color: Colors.black))))),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void clearForAppOrScreen() async{
    emailTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
  }
}
