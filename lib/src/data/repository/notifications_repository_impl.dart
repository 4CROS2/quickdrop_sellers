import 'package:quickdrop_sellers/src/data/datasource/notification_service_datasource.dart';
import 'package:quickdrop_sellers/src/domain/repository/notification_repository.dart';

class INotificationsRepository extends NotificationsRepository {
  INotificationsRepository({
    required NotificationServiceDatasource datasource,
  }) : _datasource = datasource;

  final NotificationServiceDatasource _datasource;

  @override
  Future<void> initializeNotifications() async =>
      await _datasource.initialize();
}
