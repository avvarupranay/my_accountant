import 'package:shared_preferences/shared_preferences.dart';

import '../Global/app_constants.dart';

class AppSharedPreferences{


  AppSharedPreferences();

  late SharedPreferences appSharedPref;

  static Future<bool?> getUserInfoAvailableFlag() async{
    return (await SharedPreferences.getInstance()).getBool(AppConstants.IS_USER_INFO_AVAILABLE);
  }

  static void setUserInfoAvailableFlag(bool flag) async{
    final appPref = (await SharedPreferences.getInstance());
    appPref.setBool(AppConstants.IS_USER_INFO_AVAILABLE,flag);
  }

  static void clearUserInfoAvailableFlag() async{
    final appPref = (await SharedPreferences.getInstance());
    appPref.remove(AppConstants.IS_USER_INFO_AVAILABLE);
  }
}