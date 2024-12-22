import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/cubit/schedule_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/widgets/schedule_appbar.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/widgets/schedule_tile.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  static const Map<String, String> dayTranslations = <String, String>{
    'lunes': 'monday',
    'martes': 'tuesday',
    'miércoles': 'wednesday',
    'jueves': 'thursday',
    'viernes': 'friday',
    'sábado': 'saturday',
    'domingo': 'sunday',
  };

  final List<String> days = <String>[
    'lunes',
    'martes',
    'miércoles',
    'jueves',
    'viernes',
    'sábado',
    'domingo'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (BuildContext context) => sl<ScheduleCubit>()..getSchedules(),
      child: Scaffold(
        appBar: ScheduleAppbar(),
        body: BlocConsumer<ScheduleCubit, ScheduleState>(
            listener: (BuildContext context, ScheduleState state) {
          if (state.saveStatus == ScheduleStatus.loading) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
          if (state.saveStatus == ScheduleStatus.error ||
              state.saveStatus == ScheduleStatus.success) {
            showCupertinoModalPopup(
              context: context,
              useRootNavigator: true,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  content: Text(state.message),
                );
              },
            );
          }
        }, builder: (BuildContext context, ScheduleState state) {
          return AnimatedSwitcher(
            duration: Constants.mainDuration,
            child: switch (state.status) {
              ScheduleStatus.error => _buildError(state.message),
              ScheduleStatus.success => _buildSuccess(context, state),
              _ => _buildLoading(),
            },
          );
        }),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget _buildSuccess(BuildContext context, ScheduleState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: Constants.mainPadding,
          child: const Text(
            'Selecciona los días y horas en los que opera el negocio',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Flexible(
          child: ListView.builder(
            physics: Constants.mainPhysics,
            padding: Constants.mainPadding.copyWith(top: 0),
            itemCount: days.length,
            itemBuilder: (BuildContext context, int index) {
              final String spanishDay = days[index];
              final String englishDay = dayTranslations[spanishDay]!;

              return ScheduleTile(
                onChanged: (ScheduleEntity? schedule) {
                  final ScheduleEntity? updatedSchedule = schedule?.copyWith(
                    day: dayTranslations[schedule.day] ?? schedule.day,
                  );

                  context.read<ScheduleCubit>().newSchedules(
                        day: englishDay,
                        schedule: updatedSchedule,
                      );
                },
                day: spanishDay,
                currentSchedule: state.schedules.firstWhere(
                  (ScheduleEntity element) =>
                      element.day.toLowerCase() == englishDay.toLowerCase(),
                  orElse: () => const ScheduleEntity.empty(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
