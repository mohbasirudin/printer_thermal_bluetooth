import 'package:bt_thermal/routes/controller/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';

class PageMain extends GetView<ConMain> {
  const PageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Printer Bluetooth",
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.discovery().whenComplete(
                () {
                  controller.setSearching();
                },
              );
            },
            icon: const Icon(
              Icons.sync_outlined,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Obx(
            () {
              return Container(
                height: 28,
                width: double.infinity,
                color: controller.isConnected.value ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    controller.isConnected.value
                        ? "Connected: ${controller.name.value}"
                        : "Disconnected",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.isSearching.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _viewBody();
          }
        },
      ),
      bottomNavigationBar: _viewBottom(),
    );
  }

  Widget _viewBody() {
    return ListView.separated(
      itemBuilder: (context, index) {
        PrinterDevice device = controller.devices[index];
        return Padding(
          padding: const EdgeInsets.all(
            12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      device.address ?? "-",
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.connect(device: device);
                },
                child: const Text(
                  "Connect",
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: controller.devices.length,
    );
  }

  Widget _viewBottom() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Disconnect",
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Test Print",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
