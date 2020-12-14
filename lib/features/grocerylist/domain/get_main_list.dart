import 'package:firebase_database/firebase_database.dart';
import 'package:quickfix/features/grocerylist/domain/recipe_list_model.dart';
import 'dart:async' show Future;





class MakeCall{
  List<RecipeDetailListItem> listItems=[];
// ListItem recipeModelList=new ListItem();


  Future<List<RecipeDetailListItem>> firebaseCalls (DatabaseReference databaseReference) async{
    RecipeList recipeList;
        DataSnapshot dataSnapshot = await databaseReference.once();
        Map<dynamic,dynamic> jsonResponse=dataSnapshot.value[0]['content'];
        recipeList = new RecipeList.fromJSON(jsonResponse);
        print(recipeList);
        listItems.addAll(recipeList.recipeList);
          for(var i in recipeList.recipeList){
            listItems.addAll(recipeList.recipeList);
          }
         // print(recipeList.recipeList[1].foodtitle);
          print('That ${listItems[0].name}');
//        return recipeList.recipeList;
    return listItems;
    }
  }