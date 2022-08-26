import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/api/DioClient.dart';

class AuthController extends GetxController {
  final RxBool _showProgress = false.obs;
  bool get showProgress => _showProgress.value;
  set showProgress(val) => _showProgress.value = val;

  Future<void> init() async {
    try {} catch (e) {
      showError(e);
    }
  }
}
