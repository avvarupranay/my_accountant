import 'package:flutter/cupertino.dart';

import '../Global/global_routes/app_base_screen.dart';

class AppErrorPage extends MyAccountantScreen{
  AppErrorPage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
        child : Text("There is some error Please Try Again")
    );
  }

  @override
  void clearForAppOrScreen() {
    // TODO: implement clearForAppOrScreen
  }




}