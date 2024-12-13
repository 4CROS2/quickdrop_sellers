import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class AnimationButton extends StatefulWidget {
  const AnimationButton({
    VoidCallback? ontap,
    Widget? child,
    super.key,
  })  : _child = child,
        _onTap = ontap;
  final Widget? _child;
  final VoidCallback? _onTap;

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Constants.mainDuration,
    );
    _animation = Tween<double>(begin: 1, end: .90).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            _controller.forward();
          },
          onTapUp: (TapUpDetails details) {
            _controller.reverse();
            if (widget._onTap != null) {
              widget._onTap!.call();
            }
          },
          onTapCancel: () {
            _controller.reverse();
          },
          child: widget._child ?? SizedBox.shrink()),
    );
  }
}
