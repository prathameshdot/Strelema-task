import 'package:get/get.dart';
import '../../data/services/local_storage_service.dart';

class AuthController extends GetxController {
  final _ls = LocalStorageService();
  var isLoading = false.obs;
  var phoneErr = ''.obs;
  var passErr = ''.obs;
  var isPassVis = false.obs;
  var isConfPassVis = false.obs;

  void togglePassVis() {
    isPassVis.value = !isPassVis.value;}

  void toggleConfPassVis() {
    isConfPassVis.value = !isConfPassVis.value;}

  bool valPhone(String phone) {
    if (phone.isEmpty) {
      phoneErr.value = 'Invalid phone number';
      return false;
    }
    phoneErr.value = '';
    return true;
  }

  bool valPass(String pass) {
    if (pass.length < 6) {
      passErr.value = 'Minimum 6 characters';
      return false;}
    passErr.value = '';
    return true;
  }

  Future<void> reg(String phone, String pass, String confPass) async {
    if (!valPhone(phone) || !valPass(pass)) return;
    if (pass != confPass) {
      passErr.value = 'Passwords do not match';
      return;
    }
    
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    await _ls.saveUser(phone, pass);
    isLoading.value = false;
    Get.snackbar('Success', 'Account created successfully!');
    Get.offNamed('/login');
  }

  Future<void> login(String phone, String pass) async {
    if (!valPhone(phone) || !valPass(pass)) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    String? savedP = _ls.getPhone();
    String? savedPw = _ls.getPass();
    if (savedP == phone && savedPw == pass) {
      await _ls.setAuth(true);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Invalid phone or password');
    }
    isLoading.value = false;
  }

  Future<void> logout() async {
    await _ls.logout();
    Get.offAllNamed('/login');
  }
}
