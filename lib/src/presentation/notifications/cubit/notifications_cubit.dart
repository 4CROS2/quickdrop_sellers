import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickdrop_sellers/src/domain/usecase/notification_usecase.dart';

class NotificationsCubit extends Cubit<Null> {
  NotificationsCubit({
    required NotificationUsecase usecase,
  })  : _usecase = usecase,
        super(null);

  final NotificationUsecase _usecase;

  Future<void> initializeNotifications() async {
    await _usecase.initializeNotifications();
    await _requestNotificationPermissions();
  }

  Future<void> _requestNotificationPermissions() async {
    if (Platform.isAndroid) {
      final PermissionStatus status = await Permission.notification.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        await openAppSettings();
      }
    }

    // Solicitar permisos en iOS
    if (Platform.isIOS) {
      final NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        await openAppSettings();
      }
      if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        await openAppSettings();
      }
    }
  }
}
