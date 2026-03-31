import 'package:get/get.dart';

import '../controllers/staffs_controller.dart';

class StaffsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffsController>(
      () => StaffsController(),
    );
  }
}
