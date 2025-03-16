part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => <Object>[];
}

final class LocationInitial extends LocationState {}
