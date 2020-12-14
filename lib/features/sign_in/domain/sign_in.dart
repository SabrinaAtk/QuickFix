import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String email, password;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void _signIn({String em, String pw}) {
    _auth
        .signInWithEmailAndPassword(email: em, password: pw)
        .then((authResult) {
          Navigator.pushNamed(context, '/home');
          
      }).catchError((err) {
      print(err.code);
      if (err.code == 'ERROR_WRONG_PASSWORD') {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('The password was incorrect, please try again'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.grey[300].withOpacity(0.8),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              Text(
                'SIGN IN',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (textVal) {
                  setState(() {
                    
                    email = textVal;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                  focusColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (textVal) {
                  setState(() {
                    password = textVal;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                  focusColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
               
              SizedBox(
                height: 12.0,
              ),
              InkWell(
                onTap: () {
                  loading =  true;
                  _signIn(em: email, pw: password);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 34.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                   
                  //   padding: EdgeInsets.all(20.0),
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //           image: AssetImage(
                  //               'assets/images/google-logo.png'),
                  //           fit: BoxFit.fill,
                  //         ),
                  //     color: Colors.black,
                  //     borderRadius: BorderRadius.circular(
                  //       30.0,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 38.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'FORGOT PASSWORD?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(30.0),
          color: Colors.black.withOpacity(0.9),
          child: Text(
            'DON\'T HAVE AN ACCOUNT? SIGN UP',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}