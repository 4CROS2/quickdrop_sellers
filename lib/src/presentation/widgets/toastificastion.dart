import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:toastification/toastification.dart';

class AppToastification {
  // Método estático para mostrar una notificación de error
  static void showError({
    required BuildContext context,
    required String message,
    String title = 'Error',
  }) {
    _showToastification(
      context: context,
      title: title,
      message: message,
      primaryColor: Colors.red,
      type: ToastificationType.error,
    );
  }

  // Método estático para mostrar una notificación de éxito
  static void showSuccess({
    required BuildContext context,
    required String message,
    String title = 'Success',
  }) {
    _showToastification(
      context: context,
      title: title,
      message: message,
      primaryColor: Colors.green,
      type: ToastificationType.success,
    );
  }

  // Método interno que configura la notificación
  static void _showToastification({
    required BuildContext context,
    required String title,
    required String message,
    required Color primaryColor,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      title: Text(title),
      description: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      showProgressBar: true,
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      borderRadius: Constants.mainBorderRadius,
      type: type,
      style: ToastificationStyle.flat,
      showIcon: true,
      animationBuilder: (
        BuildContext context,
        Animation<double> animation,
        Alignment alignment,
        Widget child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}