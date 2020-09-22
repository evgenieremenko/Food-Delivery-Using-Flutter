import 'package:flutter/material.dart';

const double _singleLineVerticalPadding = 14.0;

const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);
const Curve _snackBarHeightCurve = Curves.fastOutSlowIn;
const Curve _snackBarFadeInCurve =
    Interval(0.45, 1.0, curve: Curves.fastOutSlowIn);
const Curve _snackBarFadeOutCurve =
    Interval(0.72, 1.0, curve: Curves.fastOutSlowIn);

class CustomSnackBar extends StatefulWidget implements SnackBar {
  final Widget content;
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;
  final SnackBarBehavior behavior;
  final SnackBarAction action;
  final Duration duration;
  final Animation<double> animation;
  final VoidCallback onVisible;

  const CustomSnackBar(
      {Key key,
      @required this.content,
      this.backgroundColor,
      this.elevation,
      this.shape,
      this.behavior,
      this.action,
      this.duration = _snackBarDisplayDuration,
      this.animation,
      this.onVisible})
      : assert(elevation == null || elevation >= 0.0),
        assert(content != null),
        assert(duration != null),
        super(key: key);

  @override
  State<CustomSnackBar> createState() => _CustomSnackBarState();

  @override
  CustomSnackBar withAnimation(Animation<double> newAnimation,
      {Key fallbackKey}) {
    return CustomSnackBar(
      key: key ?? fallbackKey,
      content: content,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
      action: action,
      duration: duration,
      animation: newAnimation,
    );
  }

  @override
  EdgeInsetsGeometry get margin => throw UnimplementedError();

  @override
  EdgeInsetsGeometry get padding => throw UnimplementedError();

  @override
  double get width => throw UnimplementedError();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_onAnimationStatusChanged);
  }

  @override
  void didUpdateWidget(SnackBar oldWidget) {
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation.removeStatusListener(_onAnimationStatusChanged);
      widget.animation.addStatusListener(_onAnimationStatusChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus animationStatus) {
    switch (animationStatus) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (widget.onVisible != null && !_wasVisible) {
          widget.onVisible();
        }
        _wasVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    assert(widget.animation != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final SnackBarThemeData snackBarTheme = theme.snackBarTheme;
    final bool isThemeDark = theme.brightness == Brightness.dark;

    // SnackBar uses a theme that is the opposite brightness from
    // the surrounding theme.
    final Brightness brightness =
        isThemeDark ? Brightness.light : Brightness.dark;
    final Color themeBackgroundColor = isThemeDark
        ? colorScheme.onSurface
        : Color.alphaBlend(
            colorScheme.onSurface.withOpacity(0.80), colorScheme.surface);
    final ThemeData inverseTheme = ThemeData(
      brightness: brightness,
      backgroundColor: themeBackgroundColor,
      colorScheme: ColorScheme(
        primary: colorScheme.onPrimary,
        primaryVariant: colorScheme.onPrimary,
        // For the button color, the spec says it should be primaryVariant, but for
        // backward compatibility on light themes we are leaving it as secondary.
        secondary:
            isThemeDark ? colorScheme.primaryVariant : colorScheme.secondary,
        secondaryVariant: colorScheme.onSecondary,
        surface: colorScheme.onSurface,
        background: themeBackgroundColor,
        error: colorScheme.onError,
        onPrimary: colorScheme.primary,
        onSecondary: colorScheme.secondary,
        onSurface: colorScheme.surface,
        onBackground: colorScheme.background,
        onError: colorScheme.error,
        brightness: brightness,
      ),
      snackBarTheme: snackBarTheme,
    );

    final TextStyle contentTextStyle =
        snackBarTheme.contentTextStyle ?? inverseTheme.textTheme.subtitle1;
    final SnackBarBehavior snackBarBehavior =
        widget.behavior ?? snackBarTheme.behavior ?? SnackBarBehavior.fixed;
    final bool isFloatingSnackBar =
        snackBarBehavior == SnackBarBehavior.floating;
    final double snackBarPadding = isFloatingSnackBar ? 16.0 : 24.0;

    final List<Widget> children = <Widget>[
      SizedBox(width: snackBarPadding),
      Container(
        padding:
            const EdgeInsets.symmetric(vertical: _singleLineVerticalPadding),
        child: DefaultTextStyle(
          style: contentTextStyle,
          child: widget.content,
        ),
      ),
    ];
    if (widget.action != null) {
      children.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: snackBarPadding),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(color: Colors.blueAccent, width: 1.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: widget.action,
          )
        ],
      ));
    } else {
      children.add(SizedBox(width: snackBarPadding));
    }
    final CurvedAnimation heightAnimation =
        CurvedAnimation(parent: widget.animation, curve: _snackBarHeightCurve);
    final CurvedAnimation fadeInAnimation =
        CurvedAnimation(parent: widget.animation, curve: _snackBarFadeInCurve);
    final CurvedAnimation fadeOutAnimation = CurvedAnimation(
      parent: widget.animation,
      curve: _snackBarFadeOutCurve,
      reverseCurve: const Threshold(0.0),
    );

    Widget snackBar = SafeArea(
        top: false,
        bottom: !isFloatingSnackBar,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 145,
          child: Column(
            children: children,
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ));

    final double elevation = widget.elevation ?? snackBarTheme.elevation ?? 6.0;
    final Color backgroundColor = widget.backgroundColor ??
        snackBarTheme.backgroundColor ??
        inverseTheme.backgroundColor;
    final ShapeBorder shape = widget.shape ??
        snackBarTheme.shape ??
        (isFloatingSnackBar
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))
            : null);

    snackBar = Material(
      shape: shape,
      elevation: elevation,
      color: backgroundColor,
      child: Theme(
        data: inverseTheme,
        child: mediaQueryData.accessibleNavigation
            ? snackBar
            : FadeTransition(
                opacity: fadeOutAnimation,
                child: snackBar,
              ),
      ),
    );

    if (isFloatingSnackBar) {
      snackBar = Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
        child: snackBar,
      );
    }

    snackBar = Semantics(
      container: true,
      liveRegion: true,
      onDismiss: () {
        Scaffold.of(context)
            .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      },
      child: Dismissible(
        key: const Key('dismissible'),
        direction: DismissDirection.down,
        resizeDuration: null,
        onDismissed: (DismissDirection direction) {
          Scaffold.of(context)
              .removeCurrentSnackBar(reason: SnackBarClosedReason.swipe);
        },
        child: snackBar,
      ),
    );

    Widget snackBarTransition;
    if (mediaQueryData.accessibleNavigation) {
      snackBarTransition = snackBar;
    } else if (isFloatingSnackBar) {
      snackBarTransition = FadeTransition(
        opacity: fadeInAnimation,
        child: snackBar,
      );
    } else {
      snackBarTransition = AnimatedBuilder(
        animation: heightAnimation,
        builder: (BuildContext context, Widget child) {
          return Align(
            alignment: AlignmentDirectional.topStart,
            heightFactor: heightAnimation.value,
            child: child,
          );
        },
        child: snackBar,
      );
    }

    return ClipRect(child: snackBarTransition);
  }
}
