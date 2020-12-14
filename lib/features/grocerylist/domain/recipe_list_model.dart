import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';


class RecipeList{
  List<RecipeDetailListItem> recipeList;

  RecipeList({this.recipeList});

  factory RecipeList.fromJSON(Map<dynamic,dynamic> json){
    return RecipeList(
      recipeList: parserecipes(json)
    );
  }

  static List<RecipeDetailListItem> parserecipes(recipeJSON){
    var rList=recipeJSON['quickfix-4d560'] as List;
    List<RecipeDetailListItem> recipeList=rList.map((data) => RecipeDetailListItem.fromJson(data)).toList();
    return recipeList;
  }
}


class RecipeDetailListItem {
  String name;
  String uid;
  
  RecipeDetailListItem({this.name,this.uid});

  factory RecipeDetailListItem.fromJson(Map<dynamic,dynamic> parsedJson) {
//    print(parsedJson);
    return RecipeDetailListItem(name:parsedJson['name'],uid: parsedJson['uid']);
  }
}





