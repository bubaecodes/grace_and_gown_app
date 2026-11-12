import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;

  void goToTab(int index) => selectedIndex.value = index;
}