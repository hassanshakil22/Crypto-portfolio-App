import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/models/api_response.dart';
import 'package:crypto_app/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAssetDialogController extends GetxController {
  RxBool loading = false.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAsset = "".obs;
  RxDouble assetValue = 0.00.obs;
  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  Future _getData() async {
    loading.value = true;
    HTTPServices httpservice = Get.find();
    var responseData = await httpservice.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    currenciesListAPIResponse.data!.forEach((coin) {
      assets.add(coin.name!);
    });
    selectedAsset.value = assets.first;
    loading.value = false;
  }
}

class AddAssetDialog extends StatelessWidget {
  final controller = Get.put(
    AddAssetDialogController(),
  );

  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
            child: Container(
          width: MediaQuery.sizeOf(context).width * 0.80,
          height: MediaQuery.sizeOf(context).height * 0.40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: _buildUI(context),
        )),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    if (controller.loading.isTrue) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            DropdownButton(
                value: controller.selectedAsset.value,
                items: controller.assets.map((asset) {
                  return DropdownMenuItem(
                    value: asset,
                    child: Text(
                      asset,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedAsset.value = value;
                  }
                }),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.assetValue.value = double.parse(value);
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            MaterialButton(
              onPressed: () {
                AssetsController _assetsController = Get.find();
                _assetsController.addAssets(controller.selectedAsset.value,
                    controller.assetValue.value);
                Get.back(
                  closeOverlays: true,
                );
              },
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Add Asset",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }
}
