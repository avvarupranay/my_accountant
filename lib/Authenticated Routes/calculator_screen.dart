import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_accountant/Global/global_routes/app_base_screen.dart';

// ignore: must_be_immutable
class Calculator extends MyAccountantScreen {
  Calculator({super.key});

  @override
  String? get screenTitle => "Calculator";

  @override
  Icon? get rightIcon => const Icon(
        Icons.history,
        size: 30,
        color: Colors.black,
      );

  @override
  void rightIconClick(BuildContext context) {
    null;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text(screenTitle.toString()),
    );
  }

  @override
  void clearForAppOrScreen() {
    // TODO: implement clearForAppOrScreen
  }
}
