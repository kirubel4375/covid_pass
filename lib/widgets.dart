import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Functions/visibility.dart';


class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.controller, @required this.hintText, @required this.label, this.obscureText = false, this.keyboardType,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:23.0).copyWith(top: 23.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText? !Provider.of<PasswordVisibility>(context).visible : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          label: Text(label!),
          hintText: hintText,
          suffixIcon: obscureText? IconButton(
            onPressed: Provider.of<PasswordVisibility>(context, listen: false).toggleIcon,
            icon: Icon(Provider.of<PasswordVisibility>(context).currentIcon),
          ):null,
        ),
      ),
    );
  }
}



class LoginSignupSwapper extends StatelessWidget {
  const LoginSignupSwapper({
    Key? key,
    required TapGestureRecognizer tapGestureRecognizer, this.isSignup = false,
  }) : _tapGestureRecognizer = tapGestureRecognizer, super(key: key);

  final TapGestureRecognizer _tapGestureRecognizer;
  final bool isSignup;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: isSignup? "Already have an account?": "Doesn't have account yet?",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          ),
        children: [
          TextSpan(
            recognizer: _tapGestureRecognizer,
            text: isSignup? " Login": " Signup",
            style: const TextStyle(
              color:Color.fromARGB(255, 255, 60, 0),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
