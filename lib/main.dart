// import 'package:quickfix/features/meal_plan/presentation/meals_screen.dart';
// import 'package:quickfix/features/profile/presentation/body.dart';
 import 'package:quickfix/features/profile/presentation/profile_screen.dart';
import 'package:quickfix/features/sign_in/domain/create_login.dart';
//import 'package:quickfix/menu_frame.dart';
import 'package:quickfix/core/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:quickfix/constants.dart';
// import 'package:quickfix/models/NavItem.dart';
 import 'package:quickfix/features/home_screen/presentation/home.dart';
// import 'package:quickfix/features/homescreen/presentation/categories.dart';
 import 'package:quickfix/features/sign_in/domain/sign_in.dart';
//import 'package:tflite/tflite.dart';
//import 'package:quickfix/mlkit/ml_home.dart';
import 'package:flutter/services.dart';
import 'package:quickfix/features/sign_in/presentation/menu_frame.dart';

import 'features/search/presentation/search_screen.dart';
//import 'package:quickfix/core/ui/home_view.dart';
// import 'package:quickfix/features/grocerylist/presentation/list_screen.dart';
// import 'package:provider/provider.dart';

//import 'package:quickfix/features/grocerylist/domain/list_model.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'QuickFix',
              routes: <String, WidgetBuilder>{
                '/login': (context) => new SignIn(), // Login Page
                '/home': (context) => new Home(), // Home Page
                '/signUp': (context) => new CreateLogin(), // The SignUp page
                '/profile': (context) => new ProfileScreen(),
                // '/forgotPassword': (_) => new ForgotPwd(), // Forgot Password Page
                // '/screen1':(_) => new Screen1(), // Any View to be navigated from home
                },
              home: MenuFrame(),
            );
          },
        );
      },
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'QuickFix',
    //   
    //   theme: ThemeData(
    //     scaffoldBackgroundColor: Colors.orange[900],
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //     ),
    //   home: Home(),
    //   );
   }
}

