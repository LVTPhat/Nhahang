import 'package:get/get.dart';

import '../controllers/worktime_controller.dart';

class WorktimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorktimeController>(
      () => WorktimeController(),
    );
  }
}
