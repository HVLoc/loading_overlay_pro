import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class LoadingOverlayPage extends StatefulWidget {
  @override
  _LoadingOverlayPageState createState() => _LoadingOverlayPageState();
}

class _LoadingOverlayPageState extends State<LoadingOverlayPage> {
  bool _isLoading = false;

  bool _isIOS = false;

  Duration duration = Duration(seconds: 3);

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
          title: Text('Loading Overlay'),
          backgroundColor: Colors.blue,
        ),
        body: LoadingOverlayPro(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: () {
                    _isIOS = false;
                    _submit();
                  },
                  child: Text('Show Loading BouncingLine'),
                ),
                RaisedButton(
                  onPressed: () {
                    _isIOS = true;
                    _submit();
                  },
                  child: Text('Show Loading Custom IOS'),
                ),
              ],
            ),
          ),
          backgroundColor: _isIOS ? Colors.white : Colors.black54,
          isLoading: _isLoading,
          progressIndicator: _isIOS
              ? CupertinoActivityIndicator(radius: 100)
              : LoadingBouncingLine.circle(
                  backgroundColor: Colors.blue,
                  size: 150.0,
                  duration: Duration(seconds: 2),
                  borderColor: Colors.blue,
                ),
          overLoading: _isIOS
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterLogo(),
                    SizedBox(width: 10),
                    Text(
                      "Loading Overlay Pro",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                )
              : null,
          bottomLoading: _isIOS
              ? Text("Loading...", style: TextStyle(fontSize: 20.0))
              : null,
        ),
      );

  Widget test() {
    return LoadingOverlayPro(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            _submit();
          },
          child: Text('Show Loading Custom IOS'),
        ),
      ),
      backgroundColor: _isIOS ? Colors.white : Colors.black54,
      isLoading: _isLoading,
      progressIndicator: _isIOS
          ? CupertinoActivityIndicator(radius: 100)
          : LoadingBouncingLine.circle(
              backgroundColor: Colors.blue,
              size: 150.0,
              duration: Duration(seconds: 2),
              borderColor: Colors.blue,
            ),
      overLoading: Text("App Name"),
      bottomLoading: Text("Loading..."),
    );
  }
}
