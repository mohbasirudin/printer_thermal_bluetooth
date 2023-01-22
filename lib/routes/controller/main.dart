import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';

class ConMain extends GetxController {
  RxList<PrinterDevice> devices = <PrinterDevice>[].obs;
  RxBool isSearching = false.obs;
  String macAddress = "";
  RxString name = "".obs;
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    discovery().whenComplete(
      () {
        setSearching();
      },
    );

    super.onInit();
  }

  Future<void> discovery() async {
    isSearching.value = true;
    if (devices.isNotEmpty) devices.clear();
    PrinterManager.instance
        .discovery(
      type: PrinterType.bluetooth,
    )
        .listen(
      (event) {
        devices.add(event);
      },
    );
  }

  Future<void> connect({required PrinterDevice device}) async {
    await PrinterManager.instance
        .connect(
      type: PrinterType.bluetooth,
      model: BluetoothPrinterInput(
        address: device.address!,
      ),
    )
        .then(
      (value) {
        isConnected.value = value;
        if (value) {
          name.value = device.name;
          macAddress = device.address ?? "";
        }
      },
    );
  }

  void setSearching() {
    isSearching.value = false;
  }
}
