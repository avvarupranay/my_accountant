import 'package:flutter/widgets.dart';

import '../Global/global_routes/app_base_screen.dart';

// ignore: must_be_immutable
class AddNewCategoryScreen extends MyAccountantScreen {
  AddNewCategoryScreen({super.key});

  @override
  // TODO: implement screenTitle
  String? get screenTitle => "New Category";

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            appBloc.firebaseRepository.logOut();
          },
          child: Center(child : Text(screenTitle.toString())),
        )
      ],
    );
  }

  @override
  void clearForAppOrScreen() {
    null;
  }


}
