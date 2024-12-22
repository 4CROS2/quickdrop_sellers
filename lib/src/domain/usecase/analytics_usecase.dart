import 'package:quickdrop_sellers/src/domain/repository/analytics_repository.dart';

class AnalyticsUsecase {
  AnalyticsUsecase({
    required AnalyticsRepository repository,
  }) : _repository = repository;

  final AnalyticsRepository _repository;

  void logScreen(String screenName) {
    _repository.logScreenView(screenName);
  }
}
