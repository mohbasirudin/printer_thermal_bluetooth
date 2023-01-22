import 'package:bt_thermal/routes/controller/main.dart';
import 'package:get/get.dart';

class BinMain extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(
      ConMain(),
    );
  }
}
