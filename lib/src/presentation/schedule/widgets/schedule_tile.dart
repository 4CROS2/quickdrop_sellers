import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/widgets/schedule_time_picker.dart';

class ScheduleTile extends StatefulWidget {
  const ScheduleTile({
    required String day,
    required void Function(ScheduleEntity?) onChanged,
    ScheduleEntity? currentSchedule,
    super.key,
  })  : _day = day,
        _currentSchedule = currentSchedule ?? const ScheduleEntity.empty(),
        _onChanged = onChanged;

  final String _day;
  final void Function(ScheduleEntity?) _onChanged;
  final ScheduleEntity _currentSchedule;

  @override
  State<ScheduleTile> createState() => _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile> {
  bool _enabled = false;
  ScheduleEntity entity = ScheduleEntity.empty();

  @override
  void initState() {
    super.initState();
    entity = widget._currentSchedule;
    _enabled = !widget._currentSchedule.isEmpty;
  }

  void _notifyParent() {
    if (_enabled && !entity.isEmpty) {
      widget._onChanged.call(entity);
    } else {
      widget._onChanged.call(null);
    }
  }

  void _toggleValue(bool? value) {
    setState(() {
      _enabled = value!;
      if (_enabled) {
        entity = entity.copyWith(day: widget._day);
      } else {
        entity = entity.copyWith(day: '');
      }
    });
    _notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.paddingTop,
      child: Material(
        borderRadius: Constants.mainBorderRadius,
        child: Padding(
          padding: EdgeInsets.all(
            Constants.paddingValue,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    side: BorderSide(
                      width: 1,
                      color: Constants.secondaryColor,
                    ),
                    checkColor: Colors.white,
                    activeColor: Constants.secondaryColor,
                    value: _enabled,
                    onChanged: _toggleValue,
                  ),
                  Text(
                    widget._day.capitalize(),
                  ),
                ],
              ),
              Row(
                spacing: Constants.paddingValue,
                children: <Widget>[
                  Expanded(
                    child: SelectableTime(
                      enabled: _enabled,
                      icon: Icons.sunny_snowing,
                      initialValue: entity.openHour,
                      onChanged: (String? openHour) {
                        if (_enabled) {
                          entity = entity.copyWith(openHour: openHour);
                          _notifyParent();
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: SelectableTime(
                      enabled: _enabled,
                      icon: Icons.nightlight_round,
                      initialValue: entity.closeHour,
                      onChanged: (String? closeHour) {
                        if (_enabled) {
                          entity = entity.copyWith(closeHour: closeHour);
                          _notifyParent();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
