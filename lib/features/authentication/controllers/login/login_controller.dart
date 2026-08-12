import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  RxBool isVisible = false.obs;

  void isToggle(){
    isVisible.toggle();
  }
}