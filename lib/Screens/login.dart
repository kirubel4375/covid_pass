import 'package:covid_pass/Resources/auth_methods.dart';
import 'package:covid_pass/Screens/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../widgets.dart';
import 'Home/homepage.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late TapGestureRecognizer _tapGestureRecognizer;
  bool inAsyncCall = false;


    @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
    ..onTap = (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
  };
  }

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController? emailController =  TextEditingController();
    final TextEditingController? passController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: inAsyncCall,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Spacer(),
              Text(
                "The Greatest Alive", 
                style: Theme.of(context).textTheme.headline5,
                ),
              CustomField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: "Enter your email here...",
                label: "*Email",
              ),
              CustomField(
                controller: passController, 
                hintText: "Enter your password here...", 
                label: "*Password",
                obscureText: true,
                ),
              const SizedBox(height: 23),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width*.5, 40),
                ),
                onPressed: ()async{
                  setState(() {
                    inAsyncCall = true;
                  });
                  await AuthMethods().loginUser(password: passController!.text, email: emailController!.text);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
                  setState(() {
                    inAsyncCall = false;
                  });
                  }, 
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
              const Spacer(),
              LoginSignupSwapper(tapGestureRecognizer: _tapGestureRecognizer),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

