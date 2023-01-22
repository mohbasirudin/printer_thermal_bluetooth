import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
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

  Future<void> connect({
    required BuildContext context,
    required PrinterDevice device,
  }) async {
    try {
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
            snackbar(
              context: context,
              message: "Connected",
              isError: false,
            );
          } else {
            snackbar(
              context: context,
              message: "Connect",
            );
          }
        },
      );
    } catch (e) {
      snackbar(
        context: context,
        message: "Connect",
      );
    }
  }

  void print({
    required BuildContext context,
  }) async {
    try {
      CapabilityProfile profile = await CapabilityProfile.load();
      Generator generator = Generator(PaperSize.mm58, profile);
      List<int> bytes = [];

      bytes += generator.text(
        "Printer Bluetooth",
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
        ),
      );
      bytes += generator.text(
        DateTime.now().toString(),
      );
      bytes += generator.text(
        "__mohbasirudin",
      );

      await PrinterManager.instance.send(
        type: PrinterType.bluetooth,
        bytes: bytes,
      );
    } catch (e) {
      snackbar(
        context: context,
        message: "Print",
      );
    }
  }

  void snackbar({
    required BuildContext context,
    required String message,
    bool isError = true,
  }) {
    SnackBar s = SnackBar(
      content: Text(
        isError ? "Failed: $message" : "Success: $message",
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(s);
  }

  void setSearching() {
    isSearching.value = false;
  }
}
