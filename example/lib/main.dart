import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DemoPage(),
      );
}

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _isLoading = false;

  void _submit() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Loading Overlay Pro'),
          backgroundColor: Colors.blue,
        ),
        body: LoadingOverlayPro(
          child: Center(
            child: RaisedButton(
              onPressed: _submit,
              child: Text('Show Loading'),
            ),
          ),
          isLoading: _isLoading,
          progressIndicator: LoadingBouncingLine.circle(
            backgroundColor: Colors.blue,
            size: 150.0,
            duration: Duration(seconds: 2),
            borderColor: Colors.blue,
          ),
        ),
      );
}
