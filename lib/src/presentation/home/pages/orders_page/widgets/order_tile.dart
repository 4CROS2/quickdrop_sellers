import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    required String label,
    VoidCallback? onTap,
    super.key,
  })  : _label = label,
        _onTap = onTap;
  final String _label;
  final VoidCallback? _onTap;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;

  late final CurvedAnimation _curvedAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Constants.mainDuration * 2.5,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_curvedAnimation);
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_curvedAnimation);
    _rotateAnimation = Tween<double>(
      begin: 2,
      end: 0,
    ).animate(_curvedAnimation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_rotateAnimation.value),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          ),
        );
      },
      child: Padding(
        padding: Constants.paddingTop,
        child: Material(
          elevation: 1,
          shadowColor: Colors.transparent,
          borderRadius: Constants.mainBorderRadius,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: widget._onTap,
            child: Padding(
              padding: Constants.authInputContent / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Material(
                        color: Constants.mainColor,
                        clipBehavior: Clip.hardEdge,
                        borderRadius: Constants.mainBorderRadius / 2,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            'https://media.thisvid.com/contents/videos_screenshots/8237000/8237681/preview.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Constants.paddingValue,
                        ),
                        child: Text(
                          widget._label.capitalize(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('19:00')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}