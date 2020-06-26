# loading_overlay_pro

A simple widget wrapper  set of loading animations for Flutter projects.
Use animation from https://github.com/cytryn/loading-animations

## Getting Started

Then import the file to your project:
```dart
import 'package:loading_overlay_pro/loading_overlay_pro.dart'
```

Then add the following code:
```dart
 LoadingOverlayPro({
    Key key,
    @required this.isLoading,
    @required this.child,
    this.colorBackground = Colors.black54,
    this.progressIndicator = const LoadingBouncingLine.circle(),
  });
```
Or customize it even more!
```dart
LoadingBouncingLine.circle(
  borderColor: Colors.cyan,
  borderSize: 3.0,
  size: 120.0,
  backgroundColor: Colors.cyanAccent,
  duration: Duration(milliseconds: 500),
);
```

For more customization, please look inside the loading animation files.

Note: all the animations come ready to go just by calling `LoadingBouncingLine.square()`, for example.

Many basic animations contain `.circle()` and `.square()` variations by default.