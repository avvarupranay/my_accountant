
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const defaultScreenColor = Color(0xFFF8DD5F);

const String exceptionTag = "APP-EXCEPTION";
const String loginErrorTitle = "Login Error";
const String registerError = "Sign-Up Error";

String removeFalseSpaces(String text){
  //Implement-Regex-of-dart-to-complete-this-function
  return text;
}

double? lengthOfTextFormField(BuildContext context){
  return (0.825*MediaQuery.of(context).size.width);
}

double? lengthOfSubmitButton(BuildContext context){
  return (0.78*MediaQuery.of(context).size.width);
}

double? heightOfSubmitButton(BuildContext context){
  return (0.0615*MediaQuery.of(context).size.height);
}

String formatPhoneNumber(String phoneNumber){
  return "+91 ${phoneNumber.substring(0,4)}-${phoneNumber.substring(4,phoneNumber.length)}";
}