import 'package:flutter/material.dart';
import 'package:quickfix/core/constants.dart';
import 'package:quickfix/features/profile/presentation/body.dart';
import 'package:quickfix/core/size_config.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      // bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    
    return AppBar(
      backgroundColor: Colors.orange,
      leading: SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("My Profile"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize * 1.6, //16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
