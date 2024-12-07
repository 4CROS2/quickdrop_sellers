import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class CustomDropdownMenu {
  static Future<void> showCustomMenu(
    BuildContext context, {
    required GlobalKey widgetKey,
    required List<String> options,
    required Function(String) onSelected,
  }) async {
    final RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final Size screenSize = MediaQuery.of(context).size;

    final double menuHeight = options.length * 50.0; // Aproximación

    double topPosition = offset.dy + size.height;
    double bottomSpace = screenSize.height - topPosition;

    if (bottomSpace < menuHeight) {
      topPosition = offset.dy - menuHeight;
    }

    topPosition = topPosition.clamp(0.0, screenSize.height - menuHeight);

    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            // Fondo semitransparente (Barrier)
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            // Menú personalizado
            Positioned(
              left: offset.dx.clamp(
                0.0,
                screenSize.width - 250,
              ), // Asegura que no se desborde horizontalmente
              top: topPosition - 20,
              child: DropMenu(
                options: options,
                onSelected: onSelected,
              ),
            ),
          ],
        );
      },
    );
  }
}

class DropMenu extends StatefulWidget {
  const DropMenu({
    required List<String> options,
    required Function(String) onSelected,
    super.key,
  })  : _onSelected = onSelected,
        _options = options;

  final List<String> _options;
  final Function(String) _onSelected;

  @override
  State<DropMenu> createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Constants.mainDuration * 2,
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuint,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: _scaleAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
      child: Material(
        elevation: 1,
        borderRadius: Constants.mainBorderRadius,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 140,
            maxWidth: 250,
          ),
          child: Padding(
            padding: EdgeInsets.all(Constants.paddingValue),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List<Widget>.generate(
                widget._options.length,
                (int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 0 : Constants.paddingValue,
                    ),
                    child: Material(
                      color: Constants.secondaryColor.withOpacity(.1),
                      clipBehavior: Clip.hardEdge,
                      borderRadius: Constants.mainBorderRadius / 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          widget._onSelected(widget._options[index]);
                        },
                        child: Padding(
                          padding: Constants.authInputContent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget._options[index].capitalize(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* 

// CustomPainter para dibujar la flecha
class ArrowPainter extends CustomPainter {
  final Offset arrowPosition;

  ArrowPainter({required this.arrowPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Dibuja la flecha
    final Path path = Path();
    path.moveTo(arrowPosition.dx + 15, arrowPosition.dy);
    path.lineTo(arrowPosition.dx + 10, arrowPosition.dy - 10);
    path.lineTo(arrowPosition.dx + 20, arrowPosition.dy - 10);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}



 */
