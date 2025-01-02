import 'dart:convert';
import 'package:crypto_app/models/api_response.dart';
import 'package:crypto_app/models/coin_data.dart';
import 'package:crypto_app/models/tracked_asset.dart';
import 'package:crypto_app/services/http_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsController extends GetxController {
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;
  RxBool loading = false.obs;
  RxList<CoinData> coinData = <CoinData>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await _getAssets();
    _loadAssetsFromStorage();
  }

  Future _getAssets() async {
    loading.value = true;
    HTTPServices httpServices = Get.find();
    var responseData = await httpServices.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    coinData.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  Future<void> _loadAssetsFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tracked_assets");
    if (data != null) {
      trackedAssets.value = data
          .map((asset) => TrackedAsset.fromJson(jsonDecode(asset)))
          .toList();
    }
  }

  Future<void> addAssets(String name, double amount) async {
    trackedAssets.add(TrackedAsset(name: name, amount: amount));
    List<String> data = trackedAssets.map((asset) {
      return jsonEncode(asset);
    }).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("tracked_assets", data);
    print(" tracked assets list $data");

    print(" tracked assets $trackedAssets");
  }

  Future<void> removeAssets(
    String name,
  ) async {
    trackedAssets.removeWhere((asset) {
      return asset.name == name;
    });
    List<String> data = trackedAssets.map((asset) {
      return jsonEncode(asset);
    }).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("tracked_assets", data);
    print(" tracked assets list $data");
  }

  double getPortfolioValue() {
    if (trackedAssets.isEmpty) {
      return 0;
    }
    if (coinData.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      value += getAssetValue(asset.name!) * asset.amount!;
    }
    print("value $value");
    return value;
  }

  String getAssetImage(String name) {
    CoinData? coinData = getCoinData(name);
    return coinData?.images?.native ??
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYJBa944e6Syuv6VzOumLBJsQzHkH_4gyKVg&s";
  }

  double getAssetValue(String name) {
    print(" getcoindata${getCoinData(name)}");
    CoinData? coinData = getCoinData(name);

    return double.parse(coinData?.price ?? "0.00");
  }

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((coin) => coin.name == name);
  }
}
