import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/cubit/schedule_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';

class ScheduleAppbar extends CustomAppBar {
  const ScheduleAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (BuildContext context, ScheduleState state) {
        return AppBar(
          title: const Text('Horario de operaciones'),
          actions: <Widget>[
            IconButton(
              icon: Badge(
                isLabelVisible: context.read<ScheduleCubit>().hasChanges(),
                child: const Icon(Icons.save),
              ),
              onPressed: () {
                context.read<ScheduleCubit>().saveSchedules();
              },
            ),
          ],
        );
      },
    );
  }
}
