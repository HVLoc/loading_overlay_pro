import 'package:flutter/material.dart';

/// Creates a loading animation line with three shapes that bumps
class LoadingBumpingLine extends ProgressIndicator {
  /// Sets an [AnimationController] is case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController controller;

  final BoxShape _shape;

  /// The color of the shape itself.
  ///
  /// Default color is set to [Colors.blueGrey].
  final Color backgroundColor;

  /// The color of the border of the shape.
  ///
  /// Default color is set to [Colors.transparent].
  final Color borderColor;

  /// Size of the whole square containing the animation.
  ///
  /// Default size is set to [50].
  final double size;

  /// Size of the border of each shape in the line.
  ///
  /// Default size is set to [size/32].
  final double borderSize;

  /// Total duration for one cycle of animation.
  ///
  /// Default value is set to [Duration(milliseconds: 800)].
  final Duration duration;

  /// Sets an [IndexedWidgetBuilder] function to return
  /// your own customized widget.
  final IndexedWidgetBuilder itemBuilder;

  /// Creates the LoadingBumpingLine animation with a circle shape
  const LoadingBumpingLine.circle({
    Key key,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 800),
  })  : assert(backgroundColor != null,
            'loading_animations: property [backgroundColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(borderColor != null,
            'loading_animations: property [borderColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(size != null,
            'loading_animations: property [size] must not be null'),
        assert(borderSize != null ? borderSize <= size / 2 : true,
            'loading_animations: property [borderSize] must not be greater than half the widget size'),
        assert(duration != null,
            'loading_animations: property [duration] must not be null'),
        _shape = BoxShape.circle,
        super(key: key);

  /// Creates the LoadingBumpingLine animation with a square shape
  const LoadingBumpingLine.square({
    Key key,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 800),
  })  : assert(backgroundColor != null,
            'loading_animations: property [backgroundColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(borderColor != null,
            'loading_animations: property [borderColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(size != null,
            'loading_animations: property [size] must not be null'),
        assert(borderSize != null ? borderSize <= size / 2 : true,
            'loading_animations: property [borderSize] must not be greater than half the widget size'),
        assert(duration != null,
            'loading_animations: property [duration] must not be null'),
        _shape = BoxShape.rectangle,
        super(key: key);

  @override
  _LoadingBumpingLineState createState() => _LoadingBumpingLineState();
}

class _LoadingBumpingLineState extends State<LoadingBumpingLine>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1, _animation2;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(vsync: this, duration: widget.duration);

    _animation1 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInCubic),
        reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeInCubic),
      ),
    );

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
    // _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(widget.size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: widget.size / 8),
          _buildShape(_animation1, 0),
          _buildShape(null, 1),
          _buildShape(_animation2, 2),
          SizedBox(width: widget.size / 8),
        ],
      ),
    );
  }

  Widget _buildShape(Animation<double> animation, int index) {
    // final int direction = index == 0 ? -1 : 1;
    // print('direction: $direction');
    return animation != null
        ? Transform.translate(
            offset: Offset(animation.value * widget.size / 4, 0),
            child: _itemBuilder(index),
          )
        : _itemBuilder(index);
  }

  Widget _itemBuilder(int index) {
    return SizedBox.fromSize(
      size: Size.square(widget.size / 4),
      child: widget.itemBuilder != null
          ? widget.itemBuilder(context, index)
          : DecoratedBox(
              decoration: BoxDecoration(
                shape: widget._shape,
                color: widget.backgroundColor,
                border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderSize != null
                      ? widget.borderSize / 4
                      : widget.size / 32,
                  style: BorderStyle.solid,
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
