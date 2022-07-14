import 'package:covid_pass/theme_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Functions/loading.dart';
import 'Functions/visibility.dart';
import 'Screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBHTws4qdnlilnqiCQ8L9L4ihqa1MnmtdA",
        appId: "1:1075239018075:web:71deb4f8ef0c58ea5da97e",
        authDomain: "covid-app-c813a.firebaseapp.com",
        messagingSenderId: "G-GZ5EXQ5B2C",
        projectId: "covid-app-c813a",
        storageBucket: "covid-app-c813a.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => PasswordVisibility(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LoadingState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: CustomeTheme.lightTheme,
      theme: CustomeTheme.lightTheme,
      themeMode: currentTheme.currentTheme,
      // ignore: prefer_const_constructors
      home: Login(),
    );
  }
}
