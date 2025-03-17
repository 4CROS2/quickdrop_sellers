import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/cubit/schedule_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/widgets/schedule_appbar.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/widgets/schedule_tile.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/toastificastion.dart';

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
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: SizedBox(
          width: 300,
          height: 150,
          child: Material(
            borderRadius: Constants.mainBorderRadius,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Constants.paddingValue,
                children: <Widget>[
                  Center(
                    child: const CircularProgressIndicator(),
                  ),
                  const Text('Guardando cambios...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(
      BuildContext context, String message, ScheduleStatus status) {
    if (status == ScheduleStatus.success) {
      AppToastification.showSuccess(
        context: context,
        message: message,
      );
    } else {
      AppToastification.showError(
        context: context,
        message: message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (BuildContext context) => sl<ScheduleCubit>()..getSchedules(),
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        appBar: ScheduleAppbar(),
        body: BlocConsumer<ScheduleCubit, ScheduleState>(
          buildWhen: (ScheduleState previous, ScheduleState current) {
            if (previous.saveStatus == ScheduleStatus.loading &&
                    current.saveStatus == ScheduleStatus.error ||
                current.saveStatus == ScheduleStatus.success) {
              context.pop();
            }

            return true;
          },
          listener: (BuildContext context, ScheduleState state) {
            if (state.saveStatus == ScheduleStatus.loading) {
              _showLoadingDialog(context);
              return;
            }

            if (state.saveStatus == ScheduleStatus.error ||
                state.saveStatus == ScheduleStatus.success) {
              _showResultDialog(context, state.message, state.saveStatus);
            }
          },
          builder: (BuildContext context, ScheduleState state) {
            return AnimatedSwitcher(
              duration: Constants.mainDuration * 2,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: switch (state.status) {
                ScheduleStatus.error => _buildError(state.message),
                ScheduleStatus.success => _buildSuccess(context, state),
                _ => _buildLoading(),
              },
            );
          },
        ),
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

                  context.read<ScheduleCubit>().updateSchedule(
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
