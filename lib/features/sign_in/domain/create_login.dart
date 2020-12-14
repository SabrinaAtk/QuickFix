
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
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Text(
              'CREATE YOUR LOGIN',
              style: TextStyle(
                color: Colors.white,
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
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                hintText: 'Enter Email',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
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
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
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
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                hintText: 'Re-Enter Password',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
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
                      color: Colors.white,
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
                      color: Colors.white,
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
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:firebase_core/firebase_core.dart' as firebase_core;
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class CreateLogin extends StatefulWidget {
//   final Function cancelBackToHome;

//   CreateLogin({this.cancelBackToHome});

//   @override
//   _CreateLoginState createState() => _CreateLoginState();
// }

// class _CreateLoginState extends State<CreateLogin> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String firstname, lastname, email, password, passwordConfirm;
//   bool _termsAgreed = false;
//   bool saveAttempted = false;
//   final formKey = GlobalKey<FormState>();
  

//  void _createUser({String email, String pw}) {
//     _auth
//         .createUserWithEmailAndPassword(email: email, password: pw)
//         .then((authResult) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//         return Container(
//           color: Colors.yellow,
//           child: Text('Welcome ${authResult.user.email}'),
//         );
//       }));
//     }).catchError((err) {
//       print(err.code);
//       if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//         showCupertinoDialog(
//             context: context,
//             builder: (context) {
//               return CupertinoAlertDialog(
//                 title: Text(
//                     'This email already has an account associated with it'),
//                 actions: <Widget>[
//                   CupertinoDialogAction(
//                     child: Text('OK'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   )
//                 ],
//               );
//             });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Container(
//         color: Colors.grey[300].withOpacity(0.8),
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           children: <Widget>[
//             Text(
//               'CREATE YOUR LOGIN',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 26.0,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             // SizedBox(
//             //   height: 20.0,
//             // ),
//             // TextFormField(
//             //   autovalidate: saveAttempted,
//             //   onChanged: (textValue) {
//             //     setState(() {
//             //       firstname = textValue;
//             //     });
//             //   },
//             //     decoration: InputDecoration(
//             //     errorStyle: TextStyle(
//             //       color: Colors.black,
//             //     ),
//             //     enabledBorder: UnderlineInputBorder(
//             //         borderSide: BorderSide(
//             //       color: Colors.black,
//             //     )),
//             //     hintText: 'Firstname',
//             //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
//             //     focusColor: Colors.black,
//             //     focusedBorder: UnderlineInputBorder(
//             //       borderSide: BorderSide(
//             //         color: Colors.black,
//             //       ),
//             //     ),
//             //   ),
//             //   style: TextStyle(
//             //     color: Colors.black,
//             //     fontSize: 22.0,
//             //   ),
//             // ),
//             // SizedBox(
//             //   height: 20.0,
//             // ),
//             // TextFormField(
//             //   autovalidate: saveAttempted,
//             //   onChanged: (textValue) {
//             //     setState(() {
//             //       lastname = textValue;
//             //     });
//             //   },
//             //     decoration: InputDecoration(
//             //     errorStyle: TextStyle(
//             //       color: Colors.black,
//             //     ),
//             //     enabledBorder: UnderlineInputBorder(
//             //         borderSide: BorderSide(
//             //       color: Colors.black,
//             //     )),
//             //     hintText: 'Lastname',
//             //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
//             //     focusColor: Colors.black,
//             //     focusedBorder: UnderlineInputBorder(
//             //       borderSide: BorderSide(
//             //         color: Colors.black,
//             //       ),
//             //     ),
//             //   ),
//             //   style: TextStyle(
//             //     color: Colors.black,
//             //     fontSize: 22.0,
//             //   ),
//             // ),
//             SizedBox(
//               height: 20.0,
//             ),
//             TextFormField(
//               autovalidate: saveAttempted,
//               onChanged: (textValue) {
//                 setState(() {
//                   email = textValue;
//                 });
//               },
//               validator: (emailValue) {
//                 if (emailValue.isEmpty) {
//                   return 'This field is mandatory';
//                 }

//                 String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
//                     "\\@" +
//                     "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
//                     "(" +
//                     "\\." +
//                     "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
//                     ")+";
//                 RegExp regExp = new RegExp(p);

//                 if (regExp.hasMatch(emailValue)) {
//                   // So, the email is valid
//                   return null;
//                 }

//                 return 'This is not a valid email';
//               },
//               decoration: InputDecoration(
//                 errorStyle: TextStyle(
//                   color: Colors.black,
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                   color: Colors.black,
//                 )),
//                 hintText: 'Enter Email',
//                 hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
//                 focusColor: Colors.black,
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 22.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             TextFormField(
//               autovalidate: saveAttempted,
//               onChanged: (textValue) {
//                 setState(() {
//                   password = textValue;
//                 });
//               },
//               validator: (pwValue) {
//                 if (pwValue.isEmpty) {
//                   return 'This field is mandatory';
//                 }
//                 if (pwValue.length < 8) {
//                   return 'Password must be at least 8 characters';
//                 }

//                 return null;
//               },
//               obscureText: true,
//               decoration: InputDecoration(
//                 errorStyle: TextStyle(
//                   color: Colors.black,
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                   color: Colors.black,
//                 )),
//                 hintText: 'Password',
//                 hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
//                 focusColor: Colors.black,
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 22.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             TextFormField(
//               autovalidate: saveAttempted,
//               onChanged: (textValue) {
//                 setState(() {
//                   passwordConfirm = textValue;
//                 });
//               },
//               validator: (pwConfValue) {
//                 if (pwConfValue != password) {
//                   return 'Passwords must match';
//                 }

//                 return null;
//               },
//               obscureText: true,
//               decoration: InputDecoration(
//                 errorStyle: TextStyle(
//                   color: Colors.black,
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                   color: Colors.black,
//                 )),
//                 hintText: 'Re-Enter Password',
//                 hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
//                 focusColor: Colors.black,
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 22.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Checkbox(
//                   activeColor: Colors.orange,
//                   value: _termsAgreed,
//                   onChanged: (newValue) {
//                     setState(() {
//                       _termsAgreed = newValue;
//                     });
//                   },
//                 ),
//                ],
//             ),
//             SizedBox(
//               height: 12.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 InkWell(
//                   onTap: () {
//                     widget.cancelBackToHome();
//                   },
//                   child: Text(
//                     'CANCEL',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 38.0,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       saveAttempted = true;
//                     });
//                     if (formKey.currentState.validate()) {
//                       formKey.currentState.save();
//                       _createUser(email: email, pw: password);
//                     }
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 16.0,
//                       horizontal: 34.0,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(
//                         30.0,
//                       ),
//                     ),
//                     child: Text(
//                       'SAVE',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//            ],
//         ),
//       ),
//     );
//   }
// }


// // class CameraWidget extends StatefulWidget{
// //   @override
// //   State createState() {
// //     // TODO: implement createState
// //    return CameraWidgetState();
// //   }

// // }

// // class CameraWidgetState extends State{
// //   PickedFile imageFile;
// //    Future _showChoiceDialog(BuildContext context)
// //   {
// //     return showDialog(context: context,builder: (BuildContext context){

// //       return AlertDialog(
// //         title: Text("Choose option",style: TextStyle(color: Colors.blue),),
// //         content: SingleChildScrollView(
// //         child: ListBody(
// //           children: [
// //             Divider(height: 1,color: Colors.blue,),
// //             ListTile(
// //               onTap: (){
// //                 _openGallery(context);
// //               },
// //             title: Text("Gallery"),
// //               leading: Icon(Icons.account_box,color: Colors.blue,),
// //         ),

// //             Divider(height: 1,color: Colors.blue,),
// //             ListTile(
// //               onTap: (){
// //                 _openCamera(context);
// //               },
// //               title: Text("Camera"),
// //               leading: Icon(Icons.camera,color: Colors.blue,),
// //             ),
// //           ],
// //         ),
// //       ),);
// //     });
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     return  Scaffold(
// //         appBar: AppBar(
// //           title: Text("Pick Image Camera"),
// //           backgroundColor: Colors.green,
// //         ),
// //         body: Center(
// //           child: Container(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 Card(
// //                   child:( imageFile==null)?Text("Choose Image"): Image.file( File(imageFile.path)),
// //                 ),
// //                 RaisedButton(
// //                   onPressed: (){
// //                     _showChoiceDialog(context);
// //                   },
// //                   child: Text("Select Image"),

// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //       );
// //   }

// //   void _openGallery(BuildContext context) async{
// //     final pickedFile = await ImagePicker().getImage(
// //       source: ImageSource.gallery ,
// //     );
// //     setState(() {
// //       imageFile = pickedFile;
// //     });

// //     Navigator.pop(context);
// //   }

// //   void _openCamera(BuildContext context)  async{
// //       final pickedFile = await ImagePicker().getImage(
// //             source: ImageSource.camera ,
// //             );
// //             setState(() {
// //             imageFile = pickedFile;
// //       });
// //       Navigator.pop(context);
// //   }
// // }



// // class UploadingImageToFirebaseStorage extends StatefulWidget {
// //   @override
// //   _UploadingImageToFirebaseStorageState createState() =>
// //       _UploadingImageToFirebaseStorageState();
// // }

// // class _UploadingImageToFirebaseStorageState
// //     extends State<UploadingImageToFirebaseStorage> {
// //   File _imageFile;

// //   ///NOTE: Only supported on Android & iOS
// //   ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
// //   final picker = ImagePicker();

// //   Future pickImage() async {
// //     final pickedFile = await picker.getImage(source: ImageSource.camera);

// //     setState(() {
// //       _imageFile = File(pickedFile.path);
// //     });
// //   }

// //   Future uploadImageToFirebase(BuildContext context) async {
// //     String fileName = basename(_imageFile.path);
// //     StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
// //     StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
// //     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
// //     taskSnapshot.ref.getDownloadURL().then(
// //           (value) => print("Done: $value"),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: <Widget>[
// //           Container(
// //             height: 360,
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.only(
// //                     bottomLeft: Radius.circular(250.0),
// //                     bottomRight: Radius.circular(10.0)),
// //                 ),
// //           ),
// //           Container(
// //             margin: const EdgeInsets.only(top: 80),
// //             child: Column(
// //               children: <Widget>[
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Center(
// //                     child: Text(
// //                       "Uploading Image to Firebase Storage",
// //                       style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 28,
// //                           fontStyle: FontStyle.italic),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 20.0),
// //                 Expanded(
// //                   child: Stack(
// //                     children: <Widget>[
// //                       Container(
// //                         height: double.infinity,
// //                         margin: const EdgeInsets.only(
// //                             left: 30.0, right: 30.0, top: 10.0),
// //                         child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(30.0),
// //                           child: _imageFile != null
// //                               ? Image.file(_imageFile)
// //                               : FlatButton(
// //                             child: Icon(
// //                               Icons.add_a_photo,
// //                               color: Colors.blue,
// //                               size: 50,
// //                             ),
// //                             onPressed: pickImage,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 uploadImageButton(context),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget uploadImageButton(BuildContext context) {
// //     return Container(
// //       child: Stack(
// //         children: <Widget>[
// //           Container(
// //             padding:
// //             const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
// //             margin: const EdgeInsets.only(
// //                 top: 30, left: 20.0, right: 20.0, bottom: 20.0),
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(30.0)),
// //             child: FlatButton(
// //               onPressed: () => uploadImageToFirebase(context),
// //               child: Text(
// //                 "Upload Image",
// //                 style: TextStyle(fontSize: 20,color: Colors.white),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // /*
// // if request.auth != null*/