import 'package:flutter/material.dart';
import 'package:quickfix/features/homescreen/presentation/recipe_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  @override
  
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Quick",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "Fix",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
         bottom: TabBar(
            tabs: <Widget>[
              Tab(
                 child:FlatButton(
                      shape: Border.all(width: 2.0, color: Colors.lightBlue),
                      child: Text("Home"),
                      onPressed: (){
                        // some code here
                      })
              ),
              Tab(
               child:FlatButton(
                      shape: Border.all(width: 2.0, color: Colors.lightBlue),
                      child: Text("Scan"),
                      onPressed: (){
                        // some code here
                      })
              ),
              Tab(
               child:FlatButton(
                      shape: Border.all(width: 2.0, color: Colors.lightBlue),
                      child: Text("Meal Plan"),
                      onPressed: (){
                        // some code here
                      })
              ),
              Tab(
               child:FlatButton(
                      shape: Border.all(width: 2.0, color: Colors.lightBlue),
                      child: Text("Grocery List"),
                      onPressed: (){
                        // some code here
                      })
              ),
            ],
          ),
      ),
      )
    );
  }
}


class RecipeTile extends StatelessWidget {
  final String label, source, imgUrl, recipeDetailsUrl;
  RecipeTile(
      {@required this.imgUrl,
      @required this.label,
      @required this.recipeDetailsUrl,
      @required this.source});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetails(recipeDetailsUrl)));
      },
      child: Container(
        child: Stack(children: [
          Image.network(imgUrl),
          Container(
            color: Colors.blue,
            height: 50,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  source,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class CategoryRecipe extends StatefulWidget {

  final String rCategory;

  CategoryRecipe({this.rCategory});

  @override
  _CategoryRecipeState createState() => _CategoryRecipeState();
}

class _CategoryRecipeState extends State<CategoryRecipe> {
  var rlist;
  bool _loading = true;

  // @override
  // void initState() {
  //   getRecipes();
  //   // TODO: implement initState
  //   super.initState();
  // }

  // void getRecipes() async {
  //   RecipeForCategory r = RecipeForCategory();
  //   await r.getRecipeForCategory(widget.rCategory);
  //   rlist = r.r;
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              
            ),
        ),
      ),
    );
  }
}