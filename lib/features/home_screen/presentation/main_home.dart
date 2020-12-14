import 'package:flutter/material.dart';
import 'package:quickfix/core/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'dart:convert';
import 'package:quickfix/features/home_screen/domain/feed.dart';
import 'package:quickfix/features/home_screen/presentation/view_recipe.dart';
import 'package:quickfix/features/home_screen/data/api.dart';


// class Main extends StatefulWidget {
//   Main({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MainState createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Card(
//             color: Colors.grey[100],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             clipBehavior: Clip.antiAlias,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text('Rice and Peas and Fried Chicken'),
//                   subtitle: Text(
//                     'Cuisine: Jamaican | Course: BrunchSkill | Level: Medium',
//                     style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     'Jamaican Fried Chicken is a national favorite. It is served for lunch and dinner and is considered a “treat” at Sunday dinner particularly.',
//                     style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                   ),
//                 ),
//                 Image.asset(
//                   'assets/images/rice_peas_chicken.png',
//                   height: 250,
//                   width: 400,
//                 ),
//                 ButtonBar(
//                   alignment: MainAxisAlignment.start,
//                   children: [
//                     FlatButton(
//                       textColor: const Color(0xFF6200EE),
//                       onPressed: () {
//                         // Perform some action
//                       },
//                       child: const Text('SAVE'),
//                     ),
//                     FlatButton(
//                       textColor: const Color(0xFF6200EE),
//                       onPressed: () {
//                         // Perform some action
//                       },
//                       child: const Text('DISLIKE'),
//                     ),
//                     Icon(Icons.favorite),
//                     Icon(Icons.share),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             color: Colors.grey[200],
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//             clipBehavior: Clip.antiAlias,
//             child: Column(
//               children: [
//                   ListTile(
//                   title: const Text('Jamaican Ackee and Saltfish'),
//                   subtitle: Text(
//                     'Cuisine: Jamaican | Course: BrunchSkill | Level: Beginner',
//                     style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     'Ackee and Saltfish is Jamaica’s national dish. It can be eaten any time or any day of the week. However, it is traditionally served as a breakfast meal on Saturday and/or Sunday, or on special occasions...',
//                     style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                   ),
//                 ),
//                 Image.asset(
//                   'assets/images/ackee.png',
//                   height: 250,
//                   width: 400,
//                 ),
//                 ButtonBar(
//                   alignment: MainAxisAlignment.start,
//                   children: [
//                     FlatButton(
//                       textColor: const Color(0xFF6200EE),
//                       onPressed: () {
//                         // Perform some action
//                       },
//                       child: const Text('SAVE'),
//                     ),
//                     FlatButton(
//                       textColor: const Color(0xFF6200EE),
//                       onPressed: () {
//                         // Perform some action
//                       },
//                       child: const Text('DISLIKE'),
//                     ),
                     
//                     Icon(Icons.favorite),
//                     Icon(Icons.share),
                    
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

class Main extends  StatefulWidget {
  final  recipes;

  Main({Key key, this.recipes}) : super(key: key);

  @override
  _MainState createState() => _MainState();

}

class _MainState extends State<Main> {

Future<List<Recipe>> _getRecipe() async {

var url = "https://api.spoonacular.com/recipes/random?number=20";
var data = await http.get(url);

var jsonData = json.decode(data.body);

List<Recipe> recipes = [];
    for (var item in jsonData) {
      Recipe recipe = Recipe(
        
        item["id"],
        item["title"],
        item["image"],
        item["sourceName"],
        item["sourceUrl"],
        item["readyInMinutes"],
        item["extendedIngredients"]
        );

      //add data to user object
      recipes.add(recipe);
    }
    //return user list
    return recipes;
}
@override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: _getRecipe(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //use listview to display data
                return ListView.builder(
            itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].image),
                      ),
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].sourceName),
                    onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) =>

                                  RecipePage(snapshot.data[index].title, snapshot.data[index].id),
                            ));
                    } 
                  ),
                ],
              );
            });
              } else {
                return Container(
                    child: Center(
                  child: Text("Loading Data..."),
                ));
              }
          })
              );
          }

}

class Recipe {
  final String id;
  final String title;
  final String image;
  final String sourceName;
  final String sourceUrl;
  final String readyInMinutes;

  List<dynamic> extendedIngredients;

//Constructor to intitilize
  Recipe(this.id, this.title, this.image, this.sourceName, this.sourceUrl, this.readyInMinutes, this.extendedIngredients);

}