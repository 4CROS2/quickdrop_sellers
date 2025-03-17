import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:quickdrop_sellers/src/domain/usecase/location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required LocationUsecase usecase})
      : _usecase = usecase,
        super(Initial());
  final LocationUsecase _usecase;

  Future<void> getLocation() async {
    emit(Loading());
    try {
      final LocationData result = await _usecase.getLocation();
      emit(
        Success(
          location: result,
        ),
      );
    } catch (e) {
      emit(
        Error(
          message: e.toString(),
        ),
      );
    }
  }
}
