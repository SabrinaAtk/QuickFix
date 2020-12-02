
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickfix/features/homescreen/domain/recipe_model.dart';
import 'package:quickfix/features/search/data/key.dart';
import 'package:quickfix/features/homescreen/presentation/home_screen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController textEditingController = new TextEditingController();
  
  List<RecipeModel> recipes = new List<RecipeModel>();

  getRecipes(query) async {
    recipes = [];
    var url =
        "https://api.edamam.com/search?q=$query&app_id=6a73c04a&app_key=$recipeAppKey";

    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    print(jsonData);

    jsonData["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element['recipe']);

      recipes.add(recipeModel);
    });

    setState(() {});
  }
   Widget recipeGrid() {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 16),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 25, crossAxisSpacing: 30, crossAxisCount: 2),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeTile(
              imgUrl: recipes[index].image,
              label: recipes[index].label,
              recipeDetailsUrl: recipes[index].url,
              source: recipes[index].source);
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 24, right: 16, left: 16),
          child: Column(
            children: [
              Text(
                "What would you like to eat today?",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                  child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(hintText: "enter"),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        getRecipes(textEditingController.text);
                      },
                      child: Icon(Icons.search))
                ],
              )),
              recipeGrid()
            ],
          ),
        ),
      ),
    );
  }
}