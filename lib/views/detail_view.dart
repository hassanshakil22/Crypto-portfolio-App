import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/models/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailView extends StatelessWidget {
  final CoinData coinData;

  DetailView({super.key, required this.coinData});

  final AssetsController _assetsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(coinData.name!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.30,
              height: MediaQuery.sizeOf(context).height * 0.20,
              child: Image.network(
                _assetsController.getAssetImage(coinData.name!),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text:
                          "price : \$ ${twoDecimalPlaces(coinData.price!)}\n"),
                  const TextSpan(text: "Percent change : "),
                  TextSpan(
                      text:
                          "${twoDecimalPlaces(calculatePercentChange(coinData.price, coinData.high24h, coinData.low24h))} %\n",
                      style: TextStyle(
                          color: double.parse(calculatePercentChange(
                                      coinData.price,
                                      coinData.high24h,
                                      coinData.low24h)) >
                                  0
                              ? Colors.green
                              : Colors.red)),
                  TextSpan(
                      text:
                          "Highest in last 24 hours : \$ ${twoDecimalPlaces(coinData.high24h ?? "0.00")}\n"),
                  TextSpan(
                      text:
                          "Lowest in last 24 hours : \$ ${twoDecimalPlaces(coinData.low24h ?? "0.00")}"),
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                      image: NetworkImage(
                        _assetsController.getAssetImage(coinData.name!),
                      ),
                      opacity: .2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          const TextSpan(
                            text: "Rank in Market",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: "\n${coinData.rank}",
                              style: TextStyle(
                                  color: coinData.rank! <= 10
                                      ? Colors.green
                                      : coinData.rank! > 10 &&
                                              coinData.rank! <= 50
                                          ? Colors.yellow
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ])),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.5),
              children: [
                _infoCard(context, "Circulating supply ",
                    coinData.circulatingSupply ?? "null"),
                _infoCard(
                    context, "Maximum supply", coinData.maxSupply ?? "null"),
                _infoCard(
                    context, "Total supply", coinData.totalSupply ?? "null"),
                _infoCard(context, "Circulating supply",
                    coinData.circulatingSupply ?? "null"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: "\n$subtitle", style: const TextStyle(height: 5)),
              ])),
        ],
      ),
    );
  }

  String twoDecimalPlaces(String value) {
    try {
      double doubleValue = double.parse(value);
      return doubleValue.toStringAsFixed(2);
    } catch (e) {
      return value;
    }
  }

  String calculatePercentChange(
      String? currentPrice, String? high24h, String? low24h) {
    if (currentPrice == null || high24h == null || low24h == null) {
      return "0.00";
    }
    double currentprice = double.parse(currentPrice);
    double high24 = double.parse(high24h);
    double low24 = double.parse(low24h);

    double averagePrice24h = (high24 + low24) / 2;
    double percentChange =
        ((currentprice - averagePrice24h) / averagePrice24h) * 100;
    print(percentChange);
    return percentChange.toString();
  }
}
