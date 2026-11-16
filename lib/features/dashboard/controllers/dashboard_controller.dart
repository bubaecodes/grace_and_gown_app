import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  /// Index of the Bookings tab — keep in sync with the order of the tabs
  /// rendered in the dashboard's IndexedStack (and AppBottomNav).
  static const bookingsTabIndex = 3;

  final RxInt selectedIndex = 0.obs;

  void goToTab(int index) => selectedIndex.value = index;
}