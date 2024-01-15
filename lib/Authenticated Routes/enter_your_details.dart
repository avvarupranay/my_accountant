import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:my_accountant/Global/global_routes/app_base_screen.dart';

class EnterYourDetailsScreen extends MyAccountantScreen{
  EnterYourDetailsScreen({super.key});

  @override
  String? get screenTitle => "User Details";

  @override
  Icon get leftIcon => const Icon(Icons.info_outline_rounded , size: 30 , color: Colors.black,);

  @override
  Icon? get rightIcon => const Icon(Icons.settings , size: 30 , color: Colors.black,);

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text(screenTitle as String),
    );
  }

  @override
  void clearForAppOrScreen() {
    // TODO: implement clearForAppOrScreen
  }

}