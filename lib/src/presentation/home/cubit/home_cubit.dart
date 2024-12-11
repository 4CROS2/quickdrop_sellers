import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  void setPage(int page) {
    emit(
      state.copyWith(
        currentPage: page,
      ),
    );
  }

  void jumpToPage({
    required int page,
    required PageController controller,
  }) {
    setPage(page);
    controller.animateToPage(
      state.currentPage,
      duration: Constants.mainDuration,
      curve: Curves.decelerate,
    );
  }
}
