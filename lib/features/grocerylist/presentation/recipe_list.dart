import 'package:flutter/material.dart';
import 'package:quickfix/features/grocerylist/presentation/recipe_card.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:components/models/recipeListModel.dart';
import 'package:quickfix/features/grocerylist/domain/get_main_list.dart';

class List extends StatefulWidget{
  @override
  ListState createState()=> ListState();
}

class ListState extends State<List>{
  final color = const Color(0xffbfd6ba);
  final color_text = const Color(0xffd1bad6);
  final databaseReference = FirebaseDatabase.instance.reference();
  final makecall= new MakeCall();


  @override
  Widget build(BuildContext context) {

    var futureBuilder=new FutureBuilder(
      future: makecall.firebaseCalls(databaseReference), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none: return new Text('Press button to start');
          case ConnectionState.waiting: return new Text('Loading....');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
                return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index){
//                  return new Text(snapshot.data[index].foodtitle);
                   return Card(
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child:  SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
                       width: MediaQuery.of(context).size.width,
                       child:  Card(
                           elevation: 0,
                           child: Row(
                             children: <Widget>[
                                Padding(
                                 padding: const EdgeInsets.only(left: 10,right: 5,top: 5),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: <Widget>[
                                     new Container(
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: <Widget>[
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text('hi', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Roboto-Black'),),
                                               SizedBox(height:10.0),
                                               Row(
                                                 children: <Widget>[
                                                   new IconTheme(
                                                     data: new IconThemeData(
                                                         color: Colors.black26),
                                                     child: new Icon(Icons.timer,size: 20.0,),
                                                   ),
                                                   Text('minutes',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black26),)
                                                 ],
                                               )

                                             ],
                                           )
                                         ],
                                       ),
                                     ),
//                rightFavFood
                                   ],
                                 ),
                               )
                             ],
                           )
                       )


                   ),
                ),
              );
                },
                );
        }
      },
    );

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
  

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: color,
      //   elevation: 20.0,
      //   currentIndex: 0,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: new Icon(Icons.add_circle,color: Colors.white,),
      //       title: new Text('Add an Item',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700))
      //     ),
      //     ],
      // ),
    );

  }
}