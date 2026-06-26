import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/models/que_model.dart';
import '../../data/services/local_storage_service.dart';

class QueController extends GetxController {
  final QueModel queModel;
  final _ls = LocalStorageService();

  var ans = <String, String>{}.obs;
  var isSubmitting = false.obs;

  QueController(this.queModel);

  void selOpt(String qId, String opt) {
    ans[qId] = opt;
  }

  Future<void> sub() async {
    if (ans.length < queModel.ques.length) {
      Get.snackbar('Error', 'Answer all.');
      return;
    }

    isSubmitting.value = true;
    try {
      Position pos = await _getPos();
      Map<String, String> mappedAns = {};
      for (var q in queModel.ques) {
        mappedAns[q.text] = ans[q.id] ?? '';
      }

      await _ls.saveSub(
        queId: queModel.id,
        queTitle: queModel.title,
        ans: mappedAns,
        lat: pos.latitude,
        lng: pos.longitude,
      );

      Get.snackbar('Success', 'Completed');
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Error: ${e.toString()}');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<Position> _getPos() async {
    bool svcEn = await Geolocator.isLocationServiceEnabled();
    if (!svcEn) return Future.error('Location disabled.');
    LocationPermission p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
      if (p == LocationPermission.denied) {
        return Future.error('Location denied.');
      }
    }
    if (p == LocationPermission.deniedForever) {
      return Future.error('Location permanently denied.');
    } 
    return await Geolocator.getCurrentPosition();
  }
}
