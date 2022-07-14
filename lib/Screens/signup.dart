import 'package:covid_pass/Screens/Home/homepage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../Resources/auth_methods.dart';
import '../widgets.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late TapGestureRecognizer _tapGestureRecognizer;
  bool inAsyncCall = false;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
    ..onTap = (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
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
    final TextEditingController? nameController =  TextEditingController();
    final TextEditingController? idController =  TextEditingController();
    final TextEditingController? passController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: inAsyncCall,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                    Text(
                    "Register", 
                    style: Theme.of(context).textTheme.headline2,
                    ),
                  CustomField(
                    controller: nameController,
                    hintText: "Enter your full name here...",
                    label: "*Full Name",
                  ),
                  CustomField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter your email here...",
                    label: "*Email",
                  ),
                   CustomField(
                    controller: idController,
                    hintText: "Enter your id here...",
                    label: "*Id",
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
                        AuthMethods authMethods = AuthMethods();
                      String uid = await authMethods.registerUser(name: nameController!.text, password: passController!.text, email: emailController!.text, id: idController!.text);
                      await authMethods.createEmptyFile(email: emailController.text, uid: uid);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
                      setState(() {
                          inAsyncCall = false;
                        });
                      }, 
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    SizedBox(height: size.height*.2,),
                    
                  LoginSignupSwapper(tapGestureRecognizer: _tapGestureRecognizer, isSignup: true,),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


