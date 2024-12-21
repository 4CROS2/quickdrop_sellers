import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class SelectableTime extends StatefulWidget {
  const SelectableTime({
    required IconData icon,
    final String? initialValue,
    bool? enabled = true,
    void Function(String?)? onChanged,
    super.key,
  })  : _icon = icon,
        _enabled = enabled,
        _initialValue = initialValue,
        _onChanged = onChanged;

  final IconData _icon;
  final void Function(String?)? _onChanged;
  final bool? _enabled;
  final String? _initialValue;

  @override
  State<SelectableTime> createState() => _SelectableTimeState();
}

class _SelectableTimeState extends State<SelectableTime>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Constants.mainDuration,
    );
    _animation = Tween<double>(
      begin: .4,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
    if (widget._enabled == true) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SelectableTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._enabled == false) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  TimeOfDay? parseTimeString(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) {
      return null;
    }

    try {
      final List<String> parts = timeStr.split(':');
      if (parts.length != 2) {
        return null;
      }

      final int hour = int.parse(parts[0]);
      final int minute = int.parse(parts[1]);

      if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60) {
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: parseTimeString(_selectedTime ?? widget._initialValue) ??
          TimeOfDay.now(),
    );

    if (time != null) {
      final String formatedTime = _formatTime(time);
      setState(() {
        _selectedTime = formatedTime;
      });
      if (widget._onChanged != null) {
        widget._onChanged!(formatedTime);
      }
    }
  }

  String _formatTime(TimeOfDay time) {
    return time.format(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: _animation,
          child: child,
        );
      },
      child: Material(
        type: MaterialType.card,
        borderRadius: Constants.mainBorderRadius / 2,
        clipBehavior: Clip.hardEdge,
        child: IgnorePointer(
          ignoring: widget._enabled == false,
          child: InkWell(
            onTap: () => _showTimePicker(context),
            child: Padding(
              padding: Constants.mainPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(widget._icon),
                  Text(
                    _selectedTime ?? widget._initialValue!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
