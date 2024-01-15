// ignore_for_file: must_be_immutable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_accountant/App%20Bloc/app_auth_bloc.dart';
import 'package:my_accountant/Global/app_constants.dart';
import 'package:my_accountant/Global/common_utils.dart';
import 'package:my_accountant/Global/global_routes/app_base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_accountant/Loading%20Bloc/loading_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../App Widgets/password_input.dart';
import '../../Data Layer/app_shared_pref.dart';
import '../../Data Layer/firebase_data_layer.dart';
import '../../Global/app_regex.dart';
import '../../Global/global_routes/App Routes/app_routes.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UserLoginPage extends MyAccountantScreen {
  UserLoginPage({super.key});

  final loginPageKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  late BuildContext screenContext;
  late MyAccountantRepository firebaseDataLayer;

  void submit(BuildContext context) async {
    try {
      if (loginPageKey.currentState!.validate()) {
        startProgress();
        await appBloc.userLogin(emailTextController.text, passwordTextController.text);
      } else {
        showErrorDialog(context, loginErrorTitle,
            "Please give valid credentials to signing-in");
      }
    } on Exception catch (error) {
      dismissProgress();
      if(error.runtimeType == FirebaseAuthException){
        showErrorDialog(context, loginErrorTitle, (error as FirebaseAuthException).message);
      }
      else{
        print("My-Accountant - Exception : ${error.runtimeType}");
        if(appBloc.appUser!=null)
        {
          appBloc.firebaseRepository.logOut();
        }
      }
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<AppBloc, AppAuthState>(
      listener: (context, state) async{
        try{
          if (state.isAuthenticated) {
            appBloc.firebaseRepository.checkUserInfoAvailable().then((value){
              appBloc.userInfoAvailableFlag = value;
              print("userInfoAvailableFlag ? : ${appBloc.userInfoAvailableFlag}");
              if(appBloc.userInfoAvailableFlag!=null){
                AppSharedPreferences.setUserInfoAvailableFlag(appBloc.userInfoAvailableFlag!);
                dismissProgress();
                if(appBloc.userInfoAvailableFlag==true){
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyAccountantRouter.home, (route) => false);
                }
                else{
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyAccountantRouter.addUserInfo, (route) => false);
                }
              }
            }
            ).catchError(
                // ignore: argument_type_not_assignable_to_error_handler
                (){
                  if (kDebugMode) {
                    print("My-Accountant : There is some Error");
                  }
                  appBloc.firebaseRepository.logOut().then((value) => {
                    print("user-signed out successfull")
                  });
                }
            );
          }
        }
        on Exception catch(error){
          print("userInfoCheck error : ${error.runtimeType}");
        }
      },
      child: Center(
        child: Form(
          key: loginPageKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(7.5),
                child: SizedBox(
                  width: lengthOfTextFormField(context),
                  child: TextFormField(
                    key: const Key("LoginEmailEntry"),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be left empty";
                      }
                    },
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
                padding: const EdgeInsetsDirectional.all(7.5),
                child: PasswordInput(
                    passwordTextController: passwordTextController,
                    validationMessage: "Password cannot be left empty",
                    hintText: 'Enter your Password'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(7.5),
                child: SizedBox(
                    width: lengthOfSubmitButton(context),
                    height: heightOfSubmitButton(context),
                    child: ElevatedButton(
                        onPressed: () {
                          submit(context);
                        },
                        child: const Text('Submit'))),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(7.5),
                child: SizedBox(
                    width: lengthOfSubmitButton(context),
                    height: heightOfSubmitButton(context),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.redAccent, // sets background color
                        ),
                        onPressed: () {
                          submit(context);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsetsDirectional.all(2),
                              child: Icon(Icons.g_mobiledata),
                            ),
                            Padding(
                                padding: EdgeInsetsDirectional.all(2),
                                child: Text('Login in with your Google Mail'))
                          ],
                        ))),
              ),





              Padding(
                padding: const EdgeInsetsDirectional.all(5),
                child: SizedBox(
                    width: lengthOfSubmitButton(context),
                    height: heightOfSubmitButton(context),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MyAccountantRouter.register);
                        },
                        child: const Center(
                          child: Text('Not a User? SignUp',
                              style: TextStyle(color: Colors.black)),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void clearForAppOrScreen() {
    emailTextController.clear();
    passwordTextController.clear();
  }
}
