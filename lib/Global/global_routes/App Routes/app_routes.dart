import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_accountant/Authenticated%20Routes/add_new_category_screen.dart';
import 'package:my_accountant/Authenticated%20Routes/calculator_screen.dart';
import 'package:my_accountant/Authenticated%20Routes/home_view.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import '../../../App Widgets/error_page.dart';
import '../../../Authenticated Routes/review_your_expenses_screen.dart';
import '../../../Authenticated Routes/user_info_update_screen.dart';
import '../../../Authentication Routes/User Login/login_view.dart';
import '../../../Authentication Routes/User Registration/register_view.dart';

class MyAccountantRouter{
  static const login = 'login';
  static const register = 'register';
  static const addUserInfo = 'addUserInfo';
  static const home = 'home';
  static const addNewCategory = 'addNewCategory';
  static const reviewYourExpenses = 'reviewYourExpenses';
  static const calculator = 'calculator';



  static Route<dynamic>? routes(RouteSettings settings){
    switch(settings.name){
      case login:
        return MaterialPageRoute(builder: (context)=>UserLoginPage());
      case register :
        return MaterialPageRoute(builder: (context)=>UserRegisterScreen());
      case addUserInfo:
        return MaterialPageRoute(builder: (context) => UserInfoUpdatePage());
      case home :
        return MaterialPageRoute(builder: (context)=>HomePage());
      case addNewCategory :
        return CupertinoPageRoute(builder: (context)=>AddNewCategoryScreen());
      case reviewYourExpenses :
        return CupertinoPageRoute(builder: (context)=> ReviewYourExpensesScreen());
      case calculator:
        return CupertinoPageRoute(builder: (context) => Calculator());
      default:
        return CupertinoPageRoute(builder: (context)=> AppErrorPage());
    }
  }

  static String initialRoute(User? user , bool? userInfoAvailable){
    if(user!=null){
      if(userInfoAvailable==true){
        return home;
      }
      else{
        return addUserInfo;
      }
    }
    else{
      return login;
    }
  }

}