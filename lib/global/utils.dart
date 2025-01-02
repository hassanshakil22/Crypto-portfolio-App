import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/services/http_services.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  Get.put(HTTPServices());
}

Future<void> registerControllers() async {
  Get.put(AssetsController());
}
