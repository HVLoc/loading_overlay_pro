import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingPercentage extends StatefulWidget {
  const LoadingPercentage({
    Key key,
    @required this.isLoading,
    @required this.child,
    this.backgroundColor = Colors.black54,
    this.overLoading,
    this.timer = const Duration(seconds: 100),
    this.colorLoading = Colors.blue,
    this.paintingStyle = PaintingStyle.stroke,
    this.strokeJoin = StrokeJoin.round,
    this.strokeCap = StrokeCap.round,
    this.strokeWidth = 15.0,
    this.textColor,
    this.showProgress = true,
    this.bottomLoading,
  }) : super(key: key);

  /// Show/hide loading
  final bool isLoading;

  /// Defaults to [Colors.black54].
  final Color backgroundColor;

  final Widget child;

  final Widget overLoading;

  final Widget bottomLoading;

  /// Defaults to [Duration(seconds: 100)].
  final Duration timer;

  /// The color to use when stroking or filling a shape.
  ///
  /// Defaults to [Colors.blue].
  final Color colorLoading;

  /// Strategies for painting shapes and paths on a canvas.
  ///
  /// See [Paint.style].
  /// Defaults to [PaintingStyle.stroke].
  final PaintingStyle paintingStyle;

  /// Styles to use for line segment joins.
  ///
  /// This only affects line joins for polygons drawn by [Canvas.drawPath] and
  /// rectangles, not points drawn as lines with [Canvas.drawPoints].
  ///
  /// See also:
  ///
  /// * [Paint.strokeJoin] and [Paint.strokeMiterLimit] for how this value is
  ///   used.
  /// * [StrokeCap] for the different kinds of line endings.
// These enum values must be kept in sync with SkPaint::Join.
  /// Defaults to [StrokeJoin.round].
  final StrokeJoin strokeJoin;

  /// The kind of finish to place on the end of lines drawn when
  /// [style] is set to [PaintingStyle.stroke].
  ///
  /// Defaults to [StrokeCap.round], i.e. no caps.
  final StrokeCap strokeCap;

  /// How wide to make edges drawn when [style] is set to
  /// [PaintingStyle.stroke]. The width is given in logical pixels measured in
  /// the direction orthogonal to the direction of the path.
  ///
  /// Defaults to 15.0, which correspond to a hairline width.
  final double strokeWidth;

  /// color progress
  final Color textColor;

  /// Defaults to [true],
  final bool showProgress;

  @override
  _LoadingPercentageState createState() => _LoadingPercentageState();
}

class _LoadingPercentageState extends State<LoadingPercentage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.timer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      setState(() {
        _controller.reset();
        _controller.forward();
      });
    }
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
                    if (widget.overLoading != null) widget.overLoading,
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget child) {
                          return CustomPaint(
                            size: Size(MediaQuery.of(context).size.width, 50),
                            painter: PolygonPainter(
                                progress: _controller.value,
                                color: Colors.blue,
                                paintingStyle: widget.paintingStyle,
                                strokeCap: widget.strokeCap,
                                strokeJoin: widget.strokeJoin,
                                strokeWidth: widget.strokeWidth),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    if (widget.showProgress)
                      AnimatedBuilder(
                          animation: _controller,
                          builder: (BuildContext context, Widget child) {
                            return Text(
                              (_controller.value * 100).toInt().toString() +
                                  ' %',
                              style: TextStyle(color: widget.textColor),
                            );
                          }),
                    SizedBox(height: 20),
                    if (widget.bottomLoading != null) widget.bottomLoading
                  ],
                ))),
      ],
    );
  }
}

class PolygonPainter extends CustomPainter {
  PolygonPainter({
    @required this.color,
    @required this.progress,
    @required this.paintingStyle,
    @required this.strokeJoin,
    @required this.strokeCap,
    @required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final PaintingStyle paintingStyle;
  final StrokeJoin strokeJoin;
  final StrokeCap strokeCap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = paintingStyle
      ..strokeJoin = strokeJoin
      ..strokeCap = strokeCap;
    var path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2)
      ..close();
    PathMetric pathMetric = path.computeMetrics().first;
    Path extractPath =
        pathMetric.extractPath(0.0, pathMetric.length * progress / 2);

    canvas.drawPath(extractPath, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Path createPath(int sides, double radius) {
    var path = Path();
    var angle = (math.pi * 2) / sides;
    path.moveTo(radius * math.cos(0.0), radius * math.sin(0.0));
    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(angle * i);
      double y = radius * math.sin(angle * i);
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }
}
