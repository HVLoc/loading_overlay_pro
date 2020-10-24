import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class PercentPage extends StatefulWidget {
  @override
  _PercentPageState createState() => _PercentPageState();
}

class _PercentPageState extends State<PercentPage> {
  bool _isLoading = false;

  Duration duration = Duration(seconds: 10);

  void _submit() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(duration, () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Loading Percent'),
          backgroundColor: Colors.blue,
        ),
        body: LoadingPercentage(
          timer: duration,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text('Show Loading Download 10s'),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black54,
          isLoading: _isLoading,
        ),
      );
}
