import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

enum ToastType { success, error, info }

class CustomToast {
  static void toast(ToastType type, String msg) {
    String title;
    ToastificationType contentType;

    switch (type) {
      case ToastType.success:
        title = "Success";
        contentType = ToastificationType.success;
        break;
      case ToastType.error:
        title = "Error";
        contentType = ToastificationType.error;
        break;
      case ToastType.info:
        title = "Info";
        contentType = ToastificationType.info;
        break;
    }
    CustomSnackBar.show(
      title: title,
      message: msg,
      type: contentType,
      applyBlurEffect: false,
    );
  }
}
