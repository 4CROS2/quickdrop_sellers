part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.currentPage = 0,
  });
  final int currentPage;

  HomeState copyWith({
    int? currentPage,
  }) =>
      HomeState(
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object?> get props => <Object?>[currentPage];
}
