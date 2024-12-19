class AnalyticsEntity {
  AnalyticsEntity({
    required this.screenName,
    this.params,
  });
  final String screenName;
  final Map<String, dynamic>? params;
}
