import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/src/src.dart';

class LoadingOverlayPro extends StatefulWidget {
  final bool isLoading;
  final Color colorBackground;
  final Widget progressIndicator;
  final Widget child;

  const LoadingOverlayPro({
    Key key,
    @required this.isLoading,
    @required this.child,
    this.colorBackground = Colors.black54,
    this.progressIndicator = const LoadingBouncingLine.circle(),
  }) : super(key: key);

  @override
  _LoadingOverlayProState createState() => _LoadingOverlayProState();
}

class _LoadingOverlayProState extends State<LoadingOverlayPro> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Visibility(
            visible: widget.isLoading,
            child: Container(
                color: widget.colorBackground,
                child: Center(child: widget.progressIndicator))),
      ],
    );
  }
}
