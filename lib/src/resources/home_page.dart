import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginfirebase/src/blocs/home_bloc.dart';
import 'package:loginfirebase/src/resources/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summer Survey'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Click the place you like the most ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('locations').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemExtent: 60.0,
                    itemBuilder: (context, index) => _buildListItem(
                      context,
                      snapshot.data.documents[index],
                    ),
                    itemCount: snapshot.data.documents.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add new place',
        onPressed: () {
          createAddDialog(context);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              document['name'],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              document['votes'].toString(),
            ),
          )
        ],
      ),
      onTap: () {
        HomeBloc.incrementVote(document);
      },
    );
  }

  createAddDialog(BuildContext context) {
    var newPlace = '';
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add more place'),
          content: TextField(
            onChanged: (value) {
              newPlace = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            RaisedButton(
              color: Colors.lightBlue,
              elevation: 5.0,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                HomeBloc.addPlace(context, newPlace);
              },
            )
          ],
        );
      },
    );
  }
}
