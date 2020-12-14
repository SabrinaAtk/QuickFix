import 'package:flutter/material.dart';
import 'package:quickfix/features/detection/ui/camera_view.dart';
import 'package:quickfix/features/detection/ui/home_view.dart';
import 'package:quickfix/features/grocerylist/presentation/recipe_list.dart';
import 'package:quickfix/features/home_screen/presentation/main_home.dart';
import 'package:quickfix/core/size_config.dart';
import 'package:quickfix/features/meal_plan/presentation/meals_screen.dart';
import 'package:quickfix/features/profile/presentation/profile_screen.dart';
//import 'package:quickfix/features/search/presentation/search.dart'
//import 'package:quickfix/features/grocerylist/presentation/grocery_list.dart';
import 'package:quickfix/features/search/presentation/search_screen.dart';
//import 'package:quickfix/features/meal_plan/presentation/meals_screen.dart';
import 'package:quickfix/features/grocerylist/presentation/grocery_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickfix/features/search/data/key.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';


import 'package:camera/camera.dart';
import 'package:quickfix/features/detection/ui/home_view.dart';



class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    // Navigator.of(context).pushReplacement(
    //          MaterialPageRoute(
    //            builder: (context) => Carousel(),
    //          ));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: Text('QuickFix'),
          backgroundColor: Colors.orange,
        ),
        
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('My Profile Header'),
                decoration: BoxDecoration(
                 
              // image: DecorationImage(
              //   image: AssetImage("images/header.jpeg"),
                
                 color: Colors.orange,
              )
            ),
                  
                
                
              
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
             MaterialPageRoute(
               builder: (context) => ProfileScreen(),
             ));
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app
                  // ...r
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        
        body: Column(
          
          children: <Widget>[
            SizedBox(
              height: 3,
            ),
            TabBar(
                controller: tabController,
                indicatorColor: Colors.green,
                indicatorWeight: 3.0,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                      child: Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            fontFamily: 'OpenSans'),
                      ),
                      icon: Icon(Icons.home)),
                  Tab(
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            fontFamily: 'OpenSans'),
                      ),
                      icon: Icon(Icons.search)),
                  Tab(
                    child: Text("Meal Plan", style: TextStyle(
                        fontSize: 2.5 * SizeConfig.textMultiplier,
                        fontFamily: 'OpenSans'
                    ),
                    ),
                    icon: Icon(Icons.edit)),
                   Tab(
                      child: Text(
                        "Grocery List",
                        style: TextStyle(
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            fontFamily: 'OpenSans'),
                      ),
                      icon: Icon(Icons.list)),
                ]),
            Expanded(
              child: Container(
                child: TabBarView(controller: tabController, children: <Widget>[
                  Main(),
                  Search(),
                  MealsScreen(),
                  List(),
                ]),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_a_photo), onPressed: () {
               Navigator.of(context).pushReplacement(
             MaterialPageRoute(
               builder: (context) => HomeView(),
             ));
            }));
  }
}

// class Carousel extends StatefulWidget {
//   Carousel({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _CarouselState createState() => _CarouselState();
// }

// class _CarouselState extends State<Carousel> {
//   List<String> imageLinks = [
//     'https://chrisdelarosa.com/wp-content/uploads/2016/08/ackee-and-saltfish-800x530.jpg'
//     'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
//     'https://www.myforkinglife.com/wp-content/uploads/2019/07/jamaican-oxtail-16-500x453.jpg',
//     'https://foodiesterminal.com/wp-content/uploads/2020/01/soya-chunks-curry-5-678x1024.jpg'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//           CarouselSlider(
//             height: 200.0,
//             items: imageLinks.map((imageLink) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: EdgeInsets.symmetric(horizontal: 5.0),
//                       child: Image.network(
//                         imageLink,
//                         fit: BoxFit.cover,
//                       ));
//                 },
//               );
//             }).toList(),
//             reverse: false, //is false by default (reverses the order of items)
//             enableInfiniteScroll:
//                 true, //is true by default (it scrolls back to item 1 after the last item)
//             autoPlay: true, //is false by default
//             initialPage: 0, //allows you to set the first item to be displayed
//             scrollDirection: Axis.horizontal, //can be set to Axis.vertical
//             pauseAutoPlayOnTouch: Duration(
//                 seconds: 5), //it pauses the sliding if carousel is touched,
//             onPageChanged: (int pageNumber) {
// //this triggers everytime a slide changes
//             },
//             viewportFraction: 0.8,
//             enlargeCenterPage: true, //is false by default
//             aspectRatio:
//                 16 / 9, //if height is not specified, then this value is used
//           )
//         ])));
//   }
// }
