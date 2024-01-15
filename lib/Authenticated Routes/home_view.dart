import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_accountant/Global/global_routes/app_base_screen.dart';
import '../App Bloc/app_auth_bloc.dart';
import '../App Widgets/expense_management_selector_layout_animated.dart';
import '../Global/global_routes/App Routes/app_routes.dart';
import '../Loading Bloc/loading_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends MyAccountantScreen {
  HomePage({super.key});

  @override
  String? get screenTitle => "Welcome";

  @override
  Icon get leftIcon => const Icon(Icons.dehaze, size: 30, color: Colors.black);

  @override
  Icon get rightIcon =>
      const Icon(Icons.settings, size: 30, color: Colors.black);

  @override
  void rightIconClick(BuildContext context) => signOutRequest(context);

  @override
  void leftIconClick(BuildContext context) {
    print("Hamburger Clicked");
  }

  addNewCategory(BuildContext context) {
    if (kDebugMode) {
      print("Continue to add new Category");
    }
    Navigator.pushNamed(context, MyAccountantRouter.addNewCategory);
  }

  reviewExpenses(BuildContext context) {
    if (kDebugMode) {
      print("Review your Expenses");
    }
    Navigator.pushNamed(context, MyAccountantRouter.reviewYourExpenses);
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<AppBloc, AppAuthState>(

        listener: (context, state) {
          if (!state.isAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(context, MyAccountantRouter.login, (route) => false);
          }
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            ExpenseManagementSelectorLayout(
                content: "Continue to add a new Category",
                callBack: () {
                  addNewCategory(context);
                }),
            ExpenseManagementSelectorLayout(
                content: "Review your Expenses",
                callBack: () {
                  reviewExpenses(context);
                }),
          ],
        )
    );
  }

  @override
  void clearForAppOrScreen() {
    null;
  }


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
    await appBloc.firebaseRepository.logOut();
    dismissProgress();
  }
}
