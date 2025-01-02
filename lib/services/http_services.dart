import 'package:crypto_app/global/consts.dart';
import 'package:dio/dio.dart';

class HTTPServices {
  final Dio _dio = Dio();

  HTTPServices() {
    _configDio();
  }

  void _configDio() {
    _dio.options = BaseOptions(
      baseUrl: "https://api.cryptorank.io/v2/",
      headers: {
        "X-Api-Key": CRYPTO_RANK_API_KEY,
      },
    );
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
