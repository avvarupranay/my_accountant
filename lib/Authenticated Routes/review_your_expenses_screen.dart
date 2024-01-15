import 'package:flutter/widgets.dart';

import '../Global/global_routes/app_base_screen.dart';

// ignore: must_be_immutable
class ReviewYourExpensesScreen extends MyAccountantScreen {
  ReviewYourExpensesScreen({super.key});

  @override
  // TODO: implement screenTitle
  String? get screenTitle => "Review Your Expenses";

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text(screenTitle.toString()), )
      ],
    );
  }

  @override
  void clearForAppOrScreen() {
    null;
  }


}