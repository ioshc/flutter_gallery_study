import 'package:flutter/material.dart';

const double _kFrontHeadingHeight = 32.0; // front layer beveled rectangle
const double _kFrontClosedHeight = 92.0; // front layer height when closed
const double _kBackAppBarHeight = 56.0; // back layer (options) appbar height

final Tween<BorderRadius> _kFrontHeadingBevelRadius = new BorderRadiusTween(
  begin: const BorderRadius.only(
    topLeft: const Radius.circular(12.0),
    topRight: const Radius.circular(12.0),
  ),
  end: const BorderRadius.only(
    topLeft: const Radius.circular(_kFrontHeadingHeight),
    topRight: const Radius.circular(_kFrontHeadingHeight),
  ),
);

class _TappableWhileStatusIs extends StatefulWidget {
  const _TappableWhileStatusIs(this.status,
      {Key key, this.controller, this.child})
      : super(key: key);

  final AnimationController controller;
  final AnimationStatus status;
  final Widget child;

  @override
  _TappableWhileStatusIsState createState() => _TappableWhileStatusIsState();
}

class _TappableWhileStatusIsState extends State<_TappableWhileStatusIs> {
  bool _active;

  @override
  void initState() {
    super.initState();
    widget.controller.addStatusListener(_handleStatusChange);
    _active = widget.controller.status == widget.status;
  }

  @override
  void dispose() {
    widget.controller.removeStatusListener(_handleStatusChange);
    super.dispose();
  }

  void _handleStatusChange(AnimationStatus status) {
    final bool value = widget.controller.status == widget.status;
    if (_active != value) {
      setState(() {
        _active = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AbsorbPointer(
      absorbing: !_active,
      // Redundant. TODO(xster): remove after https://github.com/flutter/flutter/issues/17179.
      child: new IgnorePointer(ignoring: !_active, child: widget.child),
    );
  }
}

class _CrossFadeTransition extends AnimatedWidget {
  const _CrossFadeTransition({
    Key key,
    this.alignment: Alignment.center,
    Animation<double> progress,
    this.child0,
    this.child1,
  }) : super(key: key, listenable: progress);

  final AlignmentGeometry alignment;
  final Widget child0;
  final Widget child1;

  @override
  Widget build(BuildContext context) {
    final Animation<double> progress = listenable;

    final double opacity1 = new CurvedAnimation(
      parent: new ReverseAnimation(progress),
      curve: const Interval(0.5, 1.0),
    ).value;

    final double opacity2 = new CurvedAnimation(
      parent: progress,
      curve: const Interval(0.5, 1.0),
    ).value;

    return new Stack(
      alignment: alignment,
      children: <Widget>[
        new Opacity(
          opacity: opacity1,
          child: new Semantics(
            scopesRoute: true,
            explicitChildNodes: true,
            child: child1,
          ),
        ),
        new Opacity(
          opacity: opacity2,
          child: new Semantics(
            scopesRoute: true,
            explicitChildNodes: true,
            child: child0,
          ),
        ),
      ],
    );
  }
}

class _BackAppBar extends StatelessWidget {
  const _BackAppBar({
    Key key,
    this.leading: const SizedBox(width: 56.0),
    @required this.title,
    this.trailing,
  })  : assert(leading != null),
        assert(title != null),
        super(key: key);

  final Widget leading;
  final Widget title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      new Container(
        alignment: Alignment.center,
        width: 56.0,
        child: leading,
      ),
      new Expanded(
        child: title,
      ),
    ];

    if (trailing != null) {
      children.add(
        new Container(
          alignment: Alignment.center,
          width: 56.0,
          child: trailing,
        ),
      );
    }

    final ThemeData theme = Theme.of(context);

    return IconTheme.merge(
      data: theme.primaryIconTheme,
      child: new DefaultTextStyle(
        style: theme.primaryTextTheme.title,
        child: new SizedBox(
          height: _kBackAppBarHeight,
          child: new Row(children: children),
        ),
      ),
    );
  }
}

class Backdrop extends StatefulWidget {
  const Backdrop({
    this.frontAction,
    this.frontTitle,
    this.frontHeading,
    this.frontLayer,
    this.backTitle,
    this.backLayer,
  });

  final Widget frontAction;
  final Widget frontTitle;
  final Widget frontLayer;
  final Widget frontHeading;
  final Widget backTitle;
  final Widget backLayer;

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFrontLayer() {
    final AnimationStatus status = _controller.status;
    final bool isOpen = status == AnimationStatus.completed || status == AnimationStatus.forward;
    _controller.fling(velocity: isOpen ? -2.0 : 2.0);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> frontRelativeRect = new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(
          0.0, constraints.maxHeight - _kFrontHeadingHeight, 0.0, 0.0),
      end: new RelativeRect.fromLTRB(0.0, _kBackAppBarHeight, 0.0, 0.0),
    ).animate(_controller);

    final List<Widget> layers = <Widget>[
      // Back layer
      new Column(
        children: <Widget>[
          new _BackAppBar(
            leading: widget.frontAction,
            title: new _CrossFadeTransition(
              progress: _controller,
              alignment: AlignmentDirectional.centerStart,
              child0: new Semantics(namesRoute: true, child: widget.frontTitle),
              child1: new Semantics(namesRoute: true, child: widget.backTitle),
            ),
            trailing: new IconButton(
              onPressed: _toggleFrontLayer,
              tooltip: 'Toggle options page',
              icon: new AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _controller,
              ),
            ),
          ),
          new Expanded(
            child: new _TappableWhileStatusIs(
              AnimationStatus.dismissed,
              controller: _controller,
              child: widget.backLayer,
            ),
          ),
        ],
      ),

      // Front layer
      new PositionedTransition(
        rect: frontRelativeRect,
        child: new AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return new PhysicalShape(
              elevation: 12.0,
              color: Theme.of(context).canvasColor,
              clipper: new ShapeBorderClipper(
                shape: new BeveledRectangleBorder(
                  borderRadius:
                      _kFrontHeadingBevelRadius.lerp(_controller.value),
                ),
              ),
              child: child,
            );
          },
          child: new _TappableWhileStatusIs(
            AnimationStatus.completed,
            controller: _controller,
            child: widget.frontLayer,
          ),
        ),
      ),
    ];

    if (widget.frontHeading != null) {
      layers.add(
        new PositionedTransition(
          rect: frontRelativeRect,
          child: new ExcludeSemantics(
            child: new Container(
              alignment: Alignment.topLeft,
              child: new GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _toggleFrontLayer,
                onVerticalDragUpdate: null,
                onVerticalDragEnd: null,
                child: widget.frontHeading,
              ),
            ),
          ),
        ),
      );
    }

    return new Stack(
      children: layers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: _buildStack);
  }
}
