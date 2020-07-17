import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/animations/bouncing_line.dart';

class LoadingOverlayPro extends StatefulWidget {
  const LoadingOverlayPro({
    Key key,
    @required this.isLoading,
    @required this.child,
    this.backgroundColor = Colors.black54,
    this.progressIndicator = const LoadingBouncingLine.circle(),
    this.headerLoading,
    this.bottomLoading,
  }) : super(key: key);

  final bool isLoading;

  final Color backgroundColor;

  final Widget progressIndicator;

  final Widget child;

  final Widget headerLoading;

  final Widget bottomLoading;

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
                color: widget.backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.headerLoading != null) widget.headerLoading,
                    SizedBox(height: 20),
                    Center(child: widget.progressIndicator),
                    SizedBox(height: 20),
                    if (widget.bottomLoading != null) widget.bottomLoading,
                  ],
                ))),
      ],
    );
  }
}
