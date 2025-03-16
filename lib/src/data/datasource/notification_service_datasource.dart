import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class NotificationServiceDatasource {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    if (_auth.currentUser == null) {
      return;
    }

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
        // Obtener el documento del vendedor
        DocumentSnapshot<Map<String, dynamic>> sellerDoc =
            await _firestore.collection('sellers').doc(userId).get();

        // Verificar si el documento existe y obtener el campo lastUpdated
        if (sellerDoc.exists) {
          Timestamp? lastUpdated = sellerDoc.data()?['lastUpdated'];
          if (lastUpdated != null) {
            DateTime lastUpdatedDate = lastUpdated.toDate();
            DateTime now = DateTime.now();

            // Verificar si han pasado 24 horas desde la última actualización
            if (now.difference(lastUpdatedDate).inHours < 24) {
              // No actualizar si no han pasado 24 horas
              return;
            }
          }
        }

        // Guardar el nuevo token y actualizar lastUpdated
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
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'orders_chanel',
      'orders',
      importance: Importance.max,
      priority: Priority.high,
      colorized: true,
      color: Constants.mainColor,
      enableVibration: true,
      fullScreenIntent: true,
      playSound: true,
      enableLights: true,
      sound: RawResourceAndroidNotificationSound('@raw/notification'),
    );
    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails();
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _localNotifications.show(
      2402, // ID único de notificación
      title,
      body,
      notificationDetails,
    );
  }
}
