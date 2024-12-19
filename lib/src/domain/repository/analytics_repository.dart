abstract class AnalyticsRepository {
  void logScreenView(String screenName);
  void logEvent(String name, {Map<String, dynamic>? params});
}
