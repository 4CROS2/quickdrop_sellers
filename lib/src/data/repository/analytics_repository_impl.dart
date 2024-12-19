import 'package:quickdrop_sellers/src/data/datasource/firebase_analytics_datasource.dart';
import 'package:quickdrop_sellers/src/domain/repository/analytics_repository.dart';

class IAnalyticsRepository implements AnalyticsRepository {
  IAnalyticsRepository({
    required AnalyticsDatasource datasource,
  }) : _datasource = datasource;
  final AnalyticsDatasource _datasource;

  @override
  void logScreenView(String screenName) {
    _datasource.logScreenView(screenName);
  }

  @override
  void logEvent(String name, {Map<String, dynamic>? params}) {
    final Map<String, Object>? safeParams = params?.map(
      // ignore: always_specify_types
      (String key, value) => MapEntry<String, Object>(key, value as Object),
    );

    _datasource.logEvent(name, params: safeParams);
  }
}
