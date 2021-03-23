import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingPercentage extends StatefulWidget {
  const LoadingPercentage({
    Key? key,
    required this.isLoading,
    required this.child,
    this.backgroundColor = Colors.black54,
    this.overLoading,
    this.timer = const Duration(seconds: 100),
    this.colorLoading = Colors.blue,
    this.colorBackgroudLoading = Colors.white,
    this.paintingStyle = PaintingStyle.stroke,
    this.strokeJoin = StrokeJoin.round,
    this.strokeCap = StrokeCap.round,
    this.strokeWidth = 15.0,
    this.textColor = Colors.white,
    this.showProgress = true,
    this.bottomLoading,
    this.isLineLoading = true,
  }) : super(key: key);

  /// Show/hide loading
  final bool isLoading;

  /// Defaults to [Colors.black54].
  final Color backgroundColor;

  final Widget child;

  final Widget? overLoading;

  final Widget? bottomLoading;

  final bool isLineLoading;

  /// Defaults to [Duration(seconds: 100)].
  final Duration timer;

  /// The color to use when stroking or filling a shape.
  ///
  /// Defaults to [Colors.blue].
  final Color colorLoading;

  /// The color to use when stroking or filling a shape with LineLoading
  ///
  /// Defaults to [Colors.white].
  final Color colorBackgroudLoading;

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
  late AnimationController _controller;

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
                  children: widget.isLineLoading
                      ? buildLinePainter() as List<Widget>
                      : buildCirclePainter() as List<Widget>,
                )))
      ],
    );
  }

  List<Widget?> buildLinePainter() {
    return [
      if (widget.overLoading != null) widget.overLoading,
      SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.colorBackgroudLoading,
            borderRadius: BorderRadius.all(Radius.circular(80))),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        margin: const EdgeInsets.all(8.0),
        height: 25,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 50),
              painter: LinePainter(
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
            builder: (BuildContext context, Widget? child) {
              return _buildprogress();
            }),
      SizedBox(height: 20),
      if (widget.bottomLoading != null) widget.bottomLoading
    ];
  }

  List<Widget?> buildCirclePainter() {
    return [
      if (widget.overLoading != null) widget.overLoading,
      SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        child: Center(
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 50),
                    painter: CirclesPainter(
                        progress: _controller.value,
                        color: widget.colorLoading,
                        paintingStyle: widget.paintingStyle,
                        strokeCap: widget.strokeCap,
                        strokeJoin: widget.strokeJoin,
                        strokeWidth: widget.strokeWidth),
                  );
                },
              ),
              if (widget.showProgress)
                Center(
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget? child) {
                        return _buildprogress();
                      }),
                ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20),
      if (widget.bottomLoading != null) widget.bottomLoading
    ];
  }

  Widget _buildprogress() {
    return Text(
      _controller.value < 1
          ? (_controller.value * 100).toInt().toString() + ' %'
          : '99 %',
      style: TextStyle(color: widget.textColor, fontSize: 30),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter({
    required this.color,
    required this.progress,
    required this.paintingStyle,
    required this.strokeJoin,
    required this.strokeCap,
    required this.strokeWidth,
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
}

class CirclesPainter extends CustomPainter {
  CirclesPainter({
    required this.color,
    required this.progress,
    required this.paintingStyle,
    required this.strokeJoin,
    required this.strokeCap,
    required this.strokeWidth,
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
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: 80));

    PathMetric pathMetric = path.computeMetrics().first;
    Path extractPath =
        pathMetric.extractPath(0.0, pathMetric.length * progress);

    canvas.drawPath(extractPath, _paint);
  }

  @override
  bool shouldRepaint(CirclesPainter oldDelegate) {
    return true;
  }
}
