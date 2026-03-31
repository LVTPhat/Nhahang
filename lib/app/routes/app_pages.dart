import 'package:get/get.dart';

import 'package:sora_manager/app/modules/cooker/bindings/cooker_binding.dart';
import 'package:sora_manager/app/modules/cooker/views/cooker_view.dart';
import 'package:sora_manager/app/modules/dinnertables/bindings/dinnertables_binding.dart';
import 'package:sora_manager/app/modules/dinnertables/views/dinnertables_view.dart';
import 'package:sora_manager/app/modules/food/bindings/food_binding.dart';
import 'package:sora_manager/app/modules/food/views/food_view.dart';
import 'package:sora_manager/app/modules/home/bindings/home_binding.dart';
import 'package:sora_manager/app/modules/home/views/home_view.dart';
import 'package:sora_manager/app/modules/login/bindings/login_binding.dart';
import 'package:sora_manager/app/modules/login/views/login_view.dart';
import 'package:sora_manager/app/modules/staffs/bindings/staffs_binding.dart';
import 'package:sora_manager/app/modules/staffs/views/staffs_view.dart';
import 'package:sora_manager/app/modules/statistics/bindings/statistics_binding.dart';
import 'package:sora_manager/app/modules/statistics/views/statistics_view.dart';
import 'package:sora_manager/app/modules/worktime/bindings/worktime_binding.dart';
import 'package:sora_manager/app/modules/worktime/views/worktime_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WORKTIME,
      page: () => WorktimeView(),
      binding: WorktimeBinding(),
    ),
    GetPage(
      name: _Paths.DINNERTABLES,
      page: () => DinnertablesView(),
      binding: DinnertablesBinding(),
    ),
    GetPage(
      name: _Paths.FOOD,
      page: () => FoodView(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: _Paths.STAFFS,
      page: () => StaffsView(),
      binding: StaffsBinding(),
    ),
    GetPage(
      name: _Paths.STATISTICS,
      page: () => StatisticsView(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: _Paths.COOKER,
      page: () => CookerView(),
      binding: CookerBinding(),
    ),
  ];
}
