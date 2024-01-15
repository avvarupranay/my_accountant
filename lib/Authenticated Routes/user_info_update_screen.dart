import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_accountant/App%20Bloc/app_auth_bloc.dart';
import 'package:my_accountant/Global/global_routes/App%20Routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Global/common_utils.dart';
import '../Loading Bloc/loading_bloc.dart';

class UserInfoUpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  late AppBloc appBloc;
  late LoadingBloc loadingBloc;

  UserInfoUpdatePage({super.key});

  void signOutRequest(BuildContext context) {
    
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Sign-Out"),
              content:
                  const Text("Would you like to Sign-out of the Application"),
              actions: [
                TextButton(onPressed: logOutOfApp, child: const Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"))
              ],
            ));
  }

  void logOutOfApp() async {
    startProgress();
    appBloc.firebaseRepository.logOut();
    dismissProgress();
  }

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  DateTime? dateOfBirth;

  TextEditingController dobController = TextEditingController();

  void submit() {
    if (_formKey.currentState!.validate()) {
      print("Valid data ${dateOfBirth}");
    }
  }

  void _showDialog(BuildContext context, Widget? child) {
    FocusManager.instance.primaryFocus?.unfocus();
    showCupertinoModalPopup<void>(
      context: context,
      //barrierDismissible : false ,
      builder: (BuildContext context) => Container(
        height: 350,
        key: Key("showCupertinoModalPopup<void>"),
        //padding: const EdgeInsets.only(top: 10.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.withOpacity(0.75),
        // Use a SafeArea widget to avoid system overlaps.
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF9F9F9),
              child: Row(
                children: [
                  Expanded(
                      child: CupertinoButton(
                        onPressed: () {
                          dobController.clear();
                          Navigator.of(context).pop();
                          },
                        alignment: AlignmentDirectional.centerStart,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: CupertinoColors.destructiveRed),
                        ),
                      )
                  ),
                  Expanded(
                      child: CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          alignment: AlignmentDirectional.centerEnd,
                          child: const Text(
                            "Done",
                            //style: _cupertinoButtonStyle,
                            textAlign: TextAlign.end,
                          )
                      )
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                  color: const Color(0xFFD9DBE0),
                  child: child,
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    appBloc = context.read<AppBloc>();
    loadingBloc = context.read<LoadingBloc>();
    return BlocListener<AppBloc, AppAuthState>(
        listener: (context, state) {
          if (!state.isAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, MyAccountantRouter.login,(route) => false);
          }
        },
        child: Scaffold(
          body: Container(
            color: defaultScreenColor,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(15),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {
                          signOutRequest(context);
                        },
                        child: const Icon(
                          Icons.person_pin,
                          size: 40.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.all(7.5),
                          child: Text("Enter your First Name"),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(7.5),
                          child: SizedBox(
                            width: lengthOfTextFormField(context),
                            child: TextFormField(
                              controller: firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field cannot be left empty";
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Your First Name',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.all(7.5),
                          child: Text("Enter your Last Name"),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(7.5),
                          child: SizedBox(
                            width: lengthOfTextFormField(context),
                            child: TextFormField(
                              controller: lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field cannot be left empty";
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Your Last Name',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(7.5),
                          child: SizedBox(
                            width: lengthOfTextFormField(context),
                            child: InkWell(
                                onTap: () {
                                  _showDialog(
                                      context,
                                      CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (DateTime value) {
                                            dobController.text =
                                                "${value.day}/${value.month}/${value.year}";
                                          }));
                                },
                                child: TextFormField(
                                  enabled: false,
                                  style: const TextStyle(fontSize: 15),
                                  controller: dobController,
                                  decoration: const InputDecoration(
                                      hintText: 'Your Date of Birth',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      suffixIcon:
                                          Icon(Icons.arrow_drop_down_sharp)),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(7.5),
                          child: SizedBox(
                            width: lengthOfTextFormField(context),
                            height: 60,
                            child: ElevatedButton(
                              onPressed: submit,
                              child: const Text("Submit"),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  void startProgress() {
    loadingBloc.add(FireLoading());
  }

  void dismissProgress() {
    loadingBloc.add(CompleteLoading());
  }
}