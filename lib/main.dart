import 'package:quickfix/create_login.dart';
//import 'package:quickfix/menu_frame.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickfix/menu_frame.dart';
// import 'package:provider/provider.dart';
// import 'package:quickfix/constants.dart';
// import 'package:quickfix/models/NavItem.dart';
import 'package:quickfix/screens/home/home_screen.dart';
import 'package:quickfix/sign_in.dart';
//import 'package:tflite/tflite.dart';
//import 'package:quickfix/mlkit/ml_home.dart';
import 'package:flutter/services.dart';
import 'package:quickfix/ui/home_view.dart';
import 'package:quickfix/home_signin_widget.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickFix',
      routes: <String, WidgetBuilder>{
        '/login': (_) => new SignIn(), // Login Page
        '/home': (_) => new HomeScreen(), // Home Page
        '/signUp': (_) => new CreateLogin(), // The SignUp page
        // '/forgotPassword': (_) => new ForgotPwd(), // Forgot Password Page
        // '/screen1':(_) => new Screen1(), // Any View to be navigated from home
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orange[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: MenuFrame(),
    );
   }
}
