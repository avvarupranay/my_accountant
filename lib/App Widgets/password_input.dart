import 'package:flutter/material.dart';
import '../Global/common_utils.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key, required this.passwordTextController, required this.validationMessage, required this.hintText});
  final TextEditingController passwordTextController;
  final String validationMessage;
  final String hintText;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  late bool textVisibilityState;

  @override
  void initState() {
    super.initState();
    textVisibilityState = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: lengthOfTextFormField(context),
      child: TextFormField(
        obscureText: textVisibilityState,
        validator: (value){
          if(value==null || value.isEmpty){
            return widget.validationMessage;
          }
        },
        controller: widget.passwordTextController,

        decoration:  InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    textVisibilityState = !textVisibilityState;
                  });
                },
                child: const Icon(Icons.remove_red_eye_sharp)),
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder()),
      ),
    );
  }
}
