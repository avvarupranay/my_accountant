import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_accountant/App%20Bloc/app_auth_bloc.dart';
import 'package:my_accountant/Global/common_utils.dart';
import 'package:my_accountant/Loading%20Bloc/loading_bloc.dart';


import '../../App Widgets/animated_loader.dart';
import '../../Authenticated Routes/home_view.dart';
import 'App Routes/app_routes.dart';

// ignore: must_be_immutable
abstract class MyAccountantScreen extends StatelessWidget with RouteAware {
  MyAccountantScreen({super.key, this.resizeToAvoidBottomInset = false});

  bool? resizeToAvoidBottomInset;
  String? screenTitle;
  late AppBloc appBloc;
  late LoadingBloc loadingBloc;
  Icon? leftIcon = const Icon(
    Icons.west_sharp,
    size: 30,
    color: Colors.black,
  );
  Icon? rightIcon = const Icon(
    Icons.calculate_sharp,
    size: 30,
    color: Colors.black,
  );


  void leftIconClick(BuildContext context) {
    Navigator.pop(context);
  }

  @nonVirtual
  void startProgress(){
    loadingBloc.add(FireLoading());
  }

  @nonVirtual
  void dismissProgress(){
    loadingBloc.add(CompleteLoading());
  }

  @override
  Widget build(BuildContext context) {
    appBloc = context.read<AppBloc>();
    loadingBloc = context.read<LoadingBloc>();
    return Stack(
      children: [
        Scaffold(

          appBar: screenTitle != null ? myAccountantAppBar(context): null,

          resizeToAvoidBottomInset: resizeToAvoidBottomInset,

          backgroundColor: appBloc.state.isAuthenticated ? Colors.white : defaultScreenColor,

          drawer: runtimeType is HomePage ? Container() : null,

          body: SafeArea(child: buildBody(context)),

        ),
        BlocBuilder<LoadingBloc, LoadingState>(
          builder: (context, state) {
            return Visibility(
                visible: state is InProgress ? true : false,

                child: Container(
                  color: Colors.black.withOpacity(0.45),

                  child: const Center(

                    child: SizedBox(

                      height: 135,

                      width: 135,

                      child: Card(

                        elevation: 70,

                        child: Padding(

                          padding: EdgeInsetsDirectional.all(13),

                          child: LoadingWidget(),

                        ),

                      ),

                    ),

                  ),

                )

            );
          },
        )
      ],
    );
  }


  PreferredSize myAccountantAppBar(BuildContext context){
    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Material(
          elevation: 10,
          child: Container(
            padding: const EdgeInsetsDirectional.all(10),
            decoration: const BoxDecoration(
              color: defaultScreenColor,
              border: BorderDirectional(
                bottom: BorderSide(width: 2, color: Colors.black),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    leftIconClick(context);
                  },
                  child: leftIcon,
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Text(
                      screenTitle.toString(),
                      style: const TextStyle(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      rightIconClick(context);
                    },
                    child: rightIcon)
              ],
            ),
          ),
        ));
  }



  Widget buildBody(BuildContext context);

  void showErrorDialog(BuildContext context, String? title, String? message) {
    showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: title != null ? Text(title) : const Text("Error"),
              content: message != null
                  ? Text(message)
                  : const Text("There has been some kind of Error"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("Go back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("Clear your credentials"),
                  onPressed: () {
                    clearForAppOrScreen();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void clearForAppOrScreen();

  void rightIconClick(BuildContext context) {
    Navigator.pushNamed(context, MyAccountantRouter.calculator);
  }
}
