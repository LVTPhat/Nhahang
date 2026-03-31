import 'package:get/get.dart';

import '../controllers/dinnertables_controller.dart';

class DinnertablesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DinnertablesController>(
      () => DinnertablesController(),
    );
  }
}
