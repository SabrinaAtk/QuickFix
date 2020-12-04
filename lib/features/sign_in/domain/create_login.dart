import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateLogin extends StatefulWidget {
  final Function cancelBackToHome;

  CreateLogin({this.cancelBackToHome});

  @override
  _CreateLoginState createState() => _CreateLoginState();
}

class _CreateLoginState extends State<CreateLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password, passwordConfirm;
  bool _termsAgreed = false;
  bool saveAttempted = false;
  final formKey = GlobalKey<FormState>();

  void _createUser({String email, String pw}) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pw)
        .then((authResult) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Container(
          color: Colors.yellow,
          child: Text('Welcome ${authResult.user.email}'),
        );
      }));
    }).catchError((err) {
      print(err.code);
      if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                    'This email already has an account associated with it'),
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
    return Form(
      key: formKey,
      child: Container(
        color: Colors.grey[300].withOpacity(0.8),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Text(
              'CREATE YOUR LOGIN',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              autovalidate: saveAttempted,
              onChanged: (textValue) {
                setState(() {
                  email = textValue;
                });
              },
              validator: (emailValue) {
                if (emailValue.isEmpty) {
                  return 'This field is mandatory';
                }

                String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                    "\\@" +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                    "(" +
                    "\\." +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                    ")+";
                RegExp regExp = new RegExp(p);

                if (regExp.hasMatch(emailValue)) {
                  // So, the email is valid
                  return null;
                }

                return 'This is not a valid email';
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.black,
                ),
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
            TextFormField(
              autovalidate: saveAttempted,
              onChanged: (textValue) {
                setState(() {
                  password = textValue;
                });
              },
              validator: (pwValue) {
                if (pwValue.isEmpty) {
                  return 'This field is mandatory';
                }
                if (pwValue.length < 8) {
                  return 'Password must be at least 8 characters';
                }

                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.black,
                ),
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
              height: 20.0,
            ),
            TextFormField(
              autovalidate: saveAttempted,
              onChanged: (textValue) {
                setState(() {
                  passwordConfirm = textValue;
                });
              },
              validator: (pwConfValue) {
                if (pwConfValue != password) {
                  return 'Passwords must match';
                }

                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                )),
                hintText: 'Re-Enter Password',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  activeColor: Colors.orange,
                  value: _termsAgreed,
                  onChanged: (newValue) {
                    setState(() {
                      _termsAgreed = newValue;
                    });
                  },
                ),
               ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    widget.cancelBackToHome();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 38.0,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      saveAttempted = true;
                    });
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _createUser(email: email, pw: password);
                    }
                  },
                  child: Container(
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
                      'SAVE',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
           ],
        ),
      ),
    );
  }
}