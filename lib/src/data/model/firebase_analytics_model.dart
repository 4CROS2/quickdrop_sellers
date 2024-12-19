import 'package:quickdrop_sellers/src/domain/entity/analytics_entity.dart';

class AnalyticsModel extends AnalyticsEntity {
  AnalyticsModel({
    required super.screenName,
    super.params,
  });
  factory AnalyticsModel.fromEntity(AnalyticsEntity entity) {
    return AnalyticsModel(
      screenName: entity.screenName,
      params: entity.params,
    );
  }
}
