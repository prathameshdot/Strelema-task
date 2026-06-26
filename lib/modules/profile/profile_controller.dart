import 'package:get/get.dart';
import '../../data/services/local_storage_service.dart';

class ProfileController extends GetxController {
  final _ls = LocalStorageService();
  var uPhone = ''.obs;
  var subs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    uPhone.value = _ls.getPhone() ?? 'Unknown';
    subs.assignAll(_ls.getUserSubs());
  }

  Future<void> logout() async {
    await _ls.logout();
    Get.offAllNamed('/login');
  }
}
