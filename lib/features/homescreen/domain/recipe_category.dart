import 'package:http/http.dart' as http;
import 'package:quickfix/features/homescreen/presentation/recipe_view.dart';
import 'dart:convert';
import 'package:quickfix/features/search/data/key.dart';

class Recipe {

  List<Recipe> r  = [];

  Future<void> getNews() async{

    String url = "https://api.edamam.com/search?q=chicken&app_id=6a73c04a&app_key=$recipeAppKey&from=0&to=3&calories=591-722&health=alcohol-free";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Recipe recipe = Recipe(
            // title: element['title'],
            // author: element['author'],
            // description: element['description'],
            // urlToImage: element['urlToImage'],
            // publshedAt: DateTime.parse(element['publishedAt']),
            // content: element["content"],
            // recipeUrl: element["url"],
          );
          r.add(recipe);
        }

      });
    }


  }


}


class RecipeForCategory {

  List<Recipe> r  = [];

  Future<void> getRecipeForCategory(String category) async{

    String url = "https://api.edamam.com/app_id=6a73c04a&app_key=$recipeAppKey&country=in&category=$category&apiKey=$recipeAppKey";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["recipe"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Recipe recipe = Recipe(
            // title: element['title'],
            // author: element['author'],
            // description: element['description'],
            // urlToImage: element['urlToImage'],
            // publshedAt: DateTime.parse(element['publishedAt']),
            // content: element["content"],
            // articleUrl: element["url"],
          );
          r.add(recipe);
        }

      });
    }


  }


}


