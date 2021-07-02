import 'package:get/get.dart';
import 'package:andelinks/controllers/controllers.dart';
import 'package:andelinks/controllers/dashboardController.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController(), permanent: true);
    //Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
