import 'package:flutter/material.dart';
import 'package:quickfix/core/size_config.dart';

class Main extends StatefulWidget {
  Main({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Rice and Peas and Fried Chicken'),
                  subtitle: Text(
                    'Cuisine: Jamaican | Course: BrunchSkill | Level: Medium',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Jamaican Fried Chicken is a national favorite. It is served for lunch and dinner and is considered a “treat” at Sunday dinner particularly.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.asset(
                  'assets/images/rice_peas_chicken.png',
                  height: 250,
                  width: 400,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('SAVE'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('DISLIKE'),
                    ),
                    Icon(Icons.favorite),
                    Icon(Icons.share),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                  ListTile(
                  title: const Text('Jamaican Ackee and Saltfish'),
                  subtitle: Text(
                    'Cuisine: Jamaican | Course: BrunchSkill | Level: Beginner',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Ackee and Saltfish is Jamaica’s national dish. It can be eaten any time or any day of the week. However, it is traditionally served as a breakfast meal on Saturday and/or Sunday, or on special occasions...',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.asset(
                  'assets/images/ackee.png',
                  height: 250,
                  width: 400,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('SAVE'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('DISLIKE'),
                    ),
                     
                    Icon(Icons.favorite),
                    Icon(Icons.share),
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
