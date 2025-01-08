import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServiceDatasource {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentSound: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _saveFcmToken(userId);
    _firebaseMessaging.onTokenRefresh.listen((String newToken) async {
      await _saveFcmToken(userId);
    });
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
  }

  String get userId => _auth.currentUser!.uid;

  Future<String?> get fmcToken async => await _firebaseMessaging.getToken();

  Future<void> _saveFcmToken(String userId) async {
    String? token = await fmcToken;
    if (token != null) {
      try {
        await _firestore.collection('sellers').doc(userId).set(
          <String, Object?>{
            'fcmToken': token,
            'lastUpdated': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      } catch (e) {
        null;
      }
    }
  }

  Future<void> _onMessageHandler(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    if (notification != null) {
      await showLocalNotification(
        title: notification.title ?? 'Sin título',
        body: notification.body ?? 'Sin contenido',
      );
    }
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'orders_chanel',
      'orders',
      importance: Importance.high,
      priority: Priority.high,
    );
    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails();
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _localNotifications.show(
      0, // ID único de notificación
      title,
      body,
      notificationDetails,
    );
  }
}
