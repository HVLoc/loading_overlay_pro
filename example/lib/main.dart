import 'package:example/percentage_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_example.dart';

void main() => runApp(LoadingApp());

class LoadingApp extends StatelessWidget {
  const LoadingApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Loading Overlay Pro'),
          backgroundColor: Colors.blue,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
              child: Text("Loading overlay"),
              onPressed: () => _openPage(LoadingOverlayPage())),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
              child: Text("Loading Percent"),
              onPressed: () => _openPage(PercentPage())),
        ],
      ),
    );
  }
}
