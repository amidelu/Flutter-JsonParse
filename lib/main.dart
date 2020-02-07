import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  //Getting data from api as list
  List _data = await getJson();

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("JSON Parse"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: new Center(
        //Builder to show fetched data in list view
          child: new ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(15),
              //Passing context to use list view properties and position for getting data index position
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) return new Divider();
                return new ListTile(
                  leading: new CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: new Text("${_data[position]['title'][0].toString().toUpperCase()}",
                      style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.orangeAccent
                      ),
                    ),
                  ),
                  title: new Text(
                    "${_data[position]['title']}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  subtitle: new Text(
                    "${_data[position]['body']}",
                    style: new TextStyle(fontSize: 18.0,
                    fontStyle: FontStyle.italic
                    ),
                  ),
                );
              })),
    ),
  ));
}

//Calling future method of list for getting api data in background
Future<List> getJson() async {
  String apiURL = "http://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(apiURL);
  return json.decode(response.body);
}
