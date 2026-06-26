import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/models/que_model.dart';
import '../../data/services/mock_api_service.dart';

class HomeController extends GetxController {
  final MockApiService _ms = MockApiService();
  var isLoading = true.obs;
  var ques = <QueModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _reqPerm();
    fetchQues();
  }
  Future<void> _reqPerm() async {
    LocationPermission p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }
  Future<void> fetchQues() async {
    isLoading.value = true;
    try {
      final data = await _ms.fetchQues();
      ques.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed');
    } finally {
      isLoading.value = false;
    }
  }
}
