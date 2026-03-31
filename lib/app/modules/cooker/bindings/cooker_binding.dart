import 'package:get/get.dart';

import '../controllers/cooker_controller.dart';

class CookerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CookerController>(
      () => CookerController(),
    );
  }
}
