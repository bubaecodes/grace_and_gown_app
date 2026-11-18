import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// One entry on the Notifications screen.
class AppNotification {
  const AppNotification({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    this.read = false,
  });

  final String title;
  final String body;
  final String time;
  final IconData icon;

  /// Unread entries carry the accent dot until the user opens them.
  final bool read;

  AppNotification copyWith({bool? read}) => AppNotification(
        title: title,
        body: body,
        time: time,
        icon: icon,
        read: read ?? this.read,
      );
}

/// Recent account activity behind the Notifications screen.
///
/// Seeded with a handful of realistic entries so the screen isn't empty on
/// first open. Everything is in-memory — swap for a real feed once one
/// exists.
class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();

  static const List<AppNotification> _seed = [
    AppNotification(
      title: 'Fitting confirmed',
      body: 'Your Saturday 11:00 fitting at the Lekki Phase 1 studio is '
          'confirmed.',
      time: '2h ago',
      icon: Icons.event_available_outlined,
    ),
    AppNotification(
      title: 'Payment received',
      body: 'We received your ₦20,000 booking hold for reference GG-4821.',
      time: '5h ago',
      icon: Icons.receipt_long_outlined,
    ),
    AppNotification(
      title: 'New arrivals',
      body: 'Eight new lace gowns just landed for the owambe season.',
      time: 'Yesterday',
      icon: Icons.favorite_outline_rounded,
      read: true,
    ),
    AppNotification(
      title: 'Reminder',
      body: 'Your try-on list is ready — bring it to your next visit.',
      time: 'Mon',
      icon: Icons.schedule_rounded,
      read: true,
    ),
  ];

  final RxList<AppNotification> items = RxList<AppNotification>(_seed);

  /// How many entries still show the unread dot.
  int get unreadCount => items.where((n) => !n.read).length;

  /// Opens one entry — the tile replaces it with its read copy.
  void markRead(int index) => items[index] = items[index].copyWith(read: true);

  /// Header action: clears every unread dot at once. The mapped list is
  /// materialised first — passing the lazy `map` straight to `assignAll`
  /// would iterate it while it's being replaced and end up empty.
  void markAllRead() =>
      items.assignAll(items.map((n) => n.copyWith(read: true)).toList());

  /// Removes everything, which is what reveals the empty state.
  void clear() => items.clear();
}
