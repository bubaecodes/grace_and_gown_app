import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

// Toast queue management
bool _isToastShowing = false;
final List<void Function()> _toastQueue = [];

void _processQueue() {
  if (_isToastShowing || _toastQueue.isEmpty) return;

  _isToastShowing = true;
  final showToast = _toastQueue.removeAt(0);
  showToast();
}

void _toastCompleted() {
  _isToastShowing = false;
  // Small delay before showing next toast
  Future.delayed(const Duration(milliseconds: 300), _processQueue);
}

class CustomSnackBar {
  static ToastificationItem? show({
    required String title,
    required String message,
    required ToastificationType type,
    AlignmentGeometry alignment = Alignment.topRight,
    Duration autoCloseDuration = const Duration(seconds: 4),
    bool isDismissible = true,
    EdgeInsets? margin,
    double borderRadius = 16,
    bool showProgressBar = true,
    ToastificationStyle style = ToastificationStyle.fillColored,
    CloseButtonShowType closeButtonShowType = CloseButtonShowType.onHover,
    bool pauseOnHover = true,
    bool dragToClose = true,
    bool applyBlurEffect = true,
  }) {
    ToastificationItem? toastItem;

    void showToastInternal() {
      final context = Get.context;
      if (context == null) {
        debugPrint(
          '⚠️ CustomSnackBar: No context available - $title: $message',
        );
        _toastCompleted();
        return;
      }

      toastification.dismissAll();

      final colors = _getTypeColors(type);

      toastItem = toastification.show(
        context: context,
        type: type,
        style: style,
        title: Text(
          title,
          style: TextStyle().copyWith(
            color: colors['textPrimary'],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        description: Text(
          message,
          style: TextStyle().copyWith(
            color: colors['textSecondary'],
            fontSize: 14,
            height: 1.4,
          ),
        ),
        alignment: alignment,
        autoCloseDuration: autoCloseDuration,
        primaryColor: colors['primary'],
        backgroundColor: colors['background'],
        foregroundColor: colors['foreground'],
        icon: _getTypeIcon(type, colors['iconColor']!),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: _getBoxShadow(type),
        showProgressBar: showProgressBar,
        closeButtonShowType: closeButtonShowType,
        closeOnClick: false,
        pauseOnHover: pauseOnHover,
        dragToClose: dragToClose && isDismissible,
        applyBlurEffect: applyBlurEffect,
        margin:
        margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

      // Mark toast as completed after its duration
      Future.delayed(autoCloseDuration, () {
        _toastCompleted();
      });
    }

    _toastQueue.add(showToastInternal);
    _processQueue();

    return toastItem;
  }

  // Convenience method for success
  static ToastificationItem? success({
    String title = "Success!",
    required String message,
    AlignmentGeometry alignment = Alignment.topRight,
    Duration duration = const Duration(seconds: 4),
    bool showProgressBar = true,
  }) {
    return show(
      title: title,
      message: message,
      type: ToastificationType.success,
      alignment: alignment,
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      applyBlurEffect: true,
    );
  }

  // Convenience method for error
  static ToastificationItem? error({
    String title = "Error!",
    required String message,
    AlignmentGeometry alignment = Alignment.topRight,
    Duration duration = const Duration(seconds: 5),
    bool showProgressBar = true,
  }) {
    return show(
      title: title,
      message: message,
      type: ToastificationType.error,
      alignment: alignment,
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      closeButtonShowType: CloseButtonShowType.always,
      applyBlurEffect: true,
    );
  }

  // Convenience method for warning
  static ToastificationItem? warning({
    String title = "Warning!",
    required String message,
    AlignmentGeometry alignment = Alignment.topRight,
    Duration duration = const Duration(seconds: 4),
    bool showProgressBar = true,
  }) {
    return show(
      title: title,
      message: message,
      type: ToastificationType.warning,
      alignment: alignment,
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      applyBlurEffect: true,
    );
  }

  // Convenience method for info/help
  static ToastificationItem? info({
    String title = "Information",
    required String message,
    AlignmentGeometry alignment = Alignment.topRight,
    Duration duration = const Duration(seconds: 4),
    bool showProgressBar = true,
  }) {
    return show(
      title: title,
      message: message,
      type: ToastificationType.info,
      alignment: alignment,
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      applyBlurEffect: true,
    );
  }

  // Method to show at top center
  static ToastificationItem? showAtTop({
    required String title,
    required String message,
    required ToastificationType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    return show(
      title: title,
      message: message,
      type: type,
      alignment: Alignment.topCenter,
      autoCloseDuration: duration,
      style: ToastificationStyle.fillColored,
    );
  }

  // Method to show at bottom
  static ToastificationItem? showAtBottom({
    required String title,
    required String message,
    required ToastificationType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    return show(
      title: title,
      message: message,
      type: type,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: duration,
      style: ToastificationStyle.fillColored,
    );
  }

  // Method with floating style
  static ToastificationItem? showFloating({
    required String title,
    required String message,
    required ToastificationType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    return show(
      title: title,
      message: message,
      type: type,
      alignment: Alignment.topRight,
      autoCloseDuration: duration,
      style: ToastificationStyle.flatColored,
      borderRadius: 20,
      applyBlurEffect: true,
    );
  }

  // Simple minimal toast
  static ToastificationItem? simple({
    required String message,
    ToastificationType type = ToastificationType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    ToastificationItem? toastItem;

    void showSimpleToast() {
      final context = Get.context;
      if (context == null) {
        debugPrint('⚠️ CustomSnackBar: No context available - $message');
        _toastCompleted();
        return;
      }

      toastification.dismissAll();

      final colors = _getTypeColors(type);

      toastItem = toastification.show(
        context: context,
        type: type,
        style: ToastificationStyle.minimal,
        title: Text(
          message,
          style: TextStyle().copyWith(
            color: colors['textPrimary'],
            fontWeight: FontWeight.w600,
          ),
        ),
        alignment: Alignment.bottomCenter,
        autoCloseDuration: duration,
        showProgressBar: false,
        borderRadius: BorderRadius.circular(12),
      );

      // Mark toast as completed after its duration
      Future.delayed(duration, () {
        _toastCompleted();
      });
    }

    _toastQueue.add(showSimpleToast);
    _processQueue();

    return toastItem;
  }

  // Safe method to show after frame is built
  static void showSafe({
    required String title,
    required String message,
    required ToastificationType type,
    Duration duration = const Duration(seconds: 4),
    AlignmentGeometry alignment = Alignment.topRight,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      show(
        title: title,
        message: message,
        type: type,
        alignment: alignment,
        autoCloseDuration: duration,
      );
    });
  }

  // Method to dismiss all toasts
  static void dismissAll() {
    toastification.dismissAll();
    // Clear the queue and reset state
    _toastQueue.clear();
    _isToastShowing = false;
  }

  // Method to dismiss by ID
  static void dismiss(ToastificationItem item) {
    toastification.dismiss(item);
  }

  // Helper method to get colors based on type
  static Map<String, Color> _getTypeColors(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return {
          'primary': Colors.green,
          'background': Colors.green,
          'foreground': Colors.white,
          'textPrimary': Colors.white,
          'textSecondary': Colors.white.withValues(alpha: 0.95),
          'iconColor': Colors.white,
        };
      case ToastificationType.error:
        return {
          'primary': const Color(0xFFEF4444), // Modern red
          'background': const Color(0xFFEF4444),
          'foreground': Colors.white,
          'textPrimary': Colors.white,
          'textSecondary': Colors.white.withValues(alpha: 0.95),
          'iconColor': Colors.white,
        };
      case ToastificationType.warning:
        return {
          'primary': const Color(0xFFF59E0B), // Modern amber/orange
          'background': const Color(0xFFF59E0B),
          'foreground': Colors.white,
          'textPrimary': Colors.white,
          'textSecondary': Colors.white.withValues(alpha: 0.95),
          'iconColor': Colors.white,
        };
      case ToastificationType.info:
        return {
          'primary': const Color(0xFF3B82F6), // Modern blue
          'background': const Color(0xFF3B82F6),
          'foreground': Colors.white,
          'textPrimary': Colors.white,
          'textSecondary': Colors.white.withValues(alpha: 0.95),
          'iconColor': Colors.white,
        };
      default:
        return {
          'primary': const Color(0xFF6B7280), // Neutral gray
          'background': const Color(0xFF6B7280),
          'foreground': Colors.white,
          'textPrimary': Colors.white,
          'textSecondary': Colors.white.withValues(alpha: 0.95),
          'iconColor': Colors.white,
        };
    }
  }

  // Helper method to get icon based on type
  static Icon _getTypeIcon(ToastificationType type, Color color) {
    IconData iconData;

    switch (type) {
      case ToastificationType.success:
        iconData = Icons.check_circle_rounded;
        break;
      case ToastificationType.error:
        iconData = Icons.error_rounded;
        break;
      case ToastificationType.warning:
        iconData = Icons.warning_amber_rounded;
        break;
      case ToastificationType.info:
        iconData = Icons.info_rounded;
        break;
      default:
        iconData = Icons.notifications_rounded;
    }

    return Icon(iconData, color: color, size: 28);
  }

  // Helper method to get box shadow based on type
  static List<BoxShadow> _getBoxShadow(ToastificationType type) {
    Color shadowColor;

    switch (type) {
      case ToastificationType.success:
        shadowColor = Colors.green;
        break;
      case ToastificationType.error:
        shadowColor = const Color(0xFFEF4444);
        break;
      case ToastificationType.warning:
        shadowColor = const Color(0xFFF59E0B);
        break;
      case ToastificationType.info:
        shadowColor = const Color(0xFF3B82F6);
        break;
      default:
        shadowColor = const Color(0xFF6B7280);
    }

    return [
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.3),
        blurRadius: 16,
        offset: const Offset(0, 8),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.15),
        blurRadius: 32,
        offset: const Offset(0, 16),
        spreadRadius: 0,
      ),
    ];
  }
}
