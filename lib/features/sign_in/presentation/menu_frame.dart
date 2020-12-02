import 'package:quickfix/features/sign_in/domain/create_login.dart';
import 'package:quickfix/features/sign_in/presentation/home_signin_widget.dart';
import 'package:quickfix/features/sign_in/domain/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuFrame extends StatelessWidget {
  PageController pageController = PageController();
  Duration _animationDuration = Duration(milliseconds: 500);

  void _changePage(int page) {
    pageController.animateToPage(page,
        duration: _animationDuration, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.0, vertical: 40.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.heart,
                              color: Color.fromRGBO(255, 123, 67, 1.0),
                              size: 60.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'QUICK',
                                  style: TextStyle(
                                    fontSize: 38.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[900],
                                  ),
                                ),
                                Text(
                                  'FIX',
                                  style: TextStyle(
                                    fontSize: 38.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Eating Made Easy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: <Widget>[
                      HomeSignInWidget(
                        goToPageCallback: (page) {
                          _changePage(page);
                        },
                      ),
                      SignIn(),
                      CreateLogin(
                        cancelBackToHome: () {
                          _changePage(0);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}