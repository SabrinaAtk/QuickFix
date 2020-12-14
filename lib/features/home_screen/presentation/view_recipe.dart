import 'package:flutter/material.dart';
import 'package:quickfix/features/home_screen/presentation/main_home.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:quickfix/features/home_screen/data/api.dart';

class RecipePage extends StatelessWidget {

  final Recipe recipe_id;
  final Recipe title;
  double imageSize;
  
  RecipePage(this.recipe_id, this.title);

  @override
  Widget build(BuildContext context) {
    imageSize = MediaQuery.of(context).size.width / 3;
    return Scaffold(
        appBar: AppBar(
          title: Text(title.title),
        ),
        body: Center(
            child: FutureBuilder<Recipe>(
                future: getRecipe(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    
                    return Column(children: [
                      Text(snapshot.data.title),
                      new Container(
                          width: imageSize,
                          height: imageSize,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      NetworkImage(snapshot.data.image)))),
                      new InkWell(
                          child: new Text('Open Full Recipe',
                              style: new TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          onTap: () => _launchURL(snapshot.data.sourceUrl)),
                      Container(
                          child: new Expanded(
                              child: IngredientListView(
                        ingredients: snapshot.data.extendedIngredients,
                      )))
                    ]);
                  } else
                    return CircularProgressIndicator();
                })));
  }

Future<Recipe> getRecipe() async {
    String url = 'https://api.spoonacular.com/recipes/random?number=20';
    final response = await http.get('$url');
    Recipe theRecipe = "hey" as Recipe;
    return theRecipe;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


  
class IngredientListView extends StatelessWidget {
  final List<dynamic> ingredients;

  IngredientListView({Key key, this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ingredients.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Divider(height: 1.0),
              ListTile(
                title: Text('${ingredients[position]}'),
              ),
            ],
          );
        });
  }
}
