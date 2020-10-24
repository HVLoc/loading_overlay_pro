import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

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
