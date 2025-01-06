import 'package:quickdrop_sellers/src/domain/repository/notification_repository.dart';

class NotificationUsecase {
  NotificationUsecase({
    required NotificationsRepository repository,
  }) : _repository = repository;
  final NotificationsRepository _repository;

  Future<void> initializeNotifications() async =>
      await _repository.initializeNotifications();
}
