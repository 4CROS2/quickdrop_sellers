// data/datasource/firebase_analytics_datasource.dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsDatasource {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  void logScreenView(String screenName) {
    _analytics.logScreenView(
      screenName: screenName,
    );
  }

  void logEvent(String name, {Map<String, Object>? params}) {
    _analytics.logEvent(
      name: name,
      parameters: params,
    );
  }
}
