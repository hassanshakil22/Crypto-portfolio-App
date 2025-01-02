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
  TextEditingController _inputAmmount = TextEditingController();

  final controller = Get.put(
    AddAssetDialogController(),
  );

  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
            color: Colors.transparent, // Make Material background transparent

            borderRadius: BorderRadius.circular(15),
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
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners for the box
                border: Border.all(
                    color: Colors.grey, width: 1), // Border color and width
              ),
              child: DropdownButton<String>(
                value: controller.selectedAsset.value,
                items: controller.assets.map((asset) {
                  return DropdownMenuItem<String>(
                    value: asset,
                    child: Text(
                      asset,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedAsset.value = value;
                  }
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Theme.of(context).primaryColor,
                ),
                isDense: true,
                iconSize: 30,
                menuMaxHeight: MediaQuery.sizeOf(context).height * 0.5,
                menuWidth: MediaQuery.sizeOf(context).width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                dropdownColor: Colors.grey.shade300,
              ),
            ),
            TextField(
              controller: _inputAmmount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Asset Value',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                AssetsController _assetsController = Get.find();
                controller.assetValue.value =
                    double.tryParse(_inputAmmount.text) ?? 0.00;
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
