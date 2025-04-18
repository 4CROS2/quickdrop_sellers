import 'package:cached_network_image/cached_network_image.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/functions/time_format.dart';
import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';
import 'package:quickdrop_sellers/src/presentation/orders_page/widgets/order_tile_button.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    required OrderEntity order,
    VoidCallback? onTap,
    super.key,
  })  : _order = order,
        _onTap = onTap;
  final VoidCallback? _onTap;
  final OrderEntity _order;
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
              padding: EdgeInsets.all(Constants.paddingValue / 2),
              child: Column(
                spacing: Constants.paddingValue / 2,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            color: Constants.mainColor,
                            clipBehavior: Clip.hardEdge,
                            borderRadius: Constants.mainBorderRadius / 2,
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: CachedNetworkImage(
                                imageUrl: widget._order.image,
                                progressIndicatorBuilder: (
                                  BuildContext context,
                                  String url,
                                  DownloadProgress progress,
                                ) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Constants.secondaryColor,
                                      value: progress.progress,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Constants.paddingValue,
                                  ),
                                  child: Text(
                                    widget._order.productName.capitalize(),
                                    style: TextStyle(
                                      fontFamily: 'Questrial',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        formatHour(
                          time: widget._order.orderTime,
                        ),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Questrial',
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: Constants.paddingValue / 2,
                    children: <Widget>[
                      OrderTileButton(
                        flex: 2,
                        onTap: () {},
                        label: 'aceptar',
                        color: Colors.red,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      OrderTileButton(
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text('¿Estás seguro?'),
                                content: Text('¿Deseas rechazar este pedido?'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('cancelar'),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('rechazar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        surfaceTintColor: Colors.red,
                        label: 'rechazar',
                        elevation: 5,
                      )
                    ],
                  )
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
