import 'package:crypto_app/controllers/assets_controller.dart';
import 'package:crypto_app/global/widgets/add_asset_dialog.dart';
import 'package:crypto_app/models/tracked_asset.dart';
import 'package:crypto_app/views/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final AssetsController _assetsController = Get.find();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Asset DashBoard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 5,
        leading: const Icon(Icons.account_balance_wallet, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(AddAssetDialog());
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [_buildUI(context), _portfolioList(context)],
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => _assetsController.loading.value == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            const TextSpan(
                                text: "\$ ",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            TextSpan(
                                text: _assetsController
                                    .getPortfolioValue()
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            const TextSpan(
                              text: "\n Portfolio value",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ));
  }

  Widget _portfolioList(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            const Text(
              "Coins",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))),
              height: MediaQuery.sizeOf(context).height * 0.65,
              child: ListView.builder(
                  itemCount: _assetsController.trackedAssets.length,
                  itemBuilder: (context, index) {
                    TrackedAsset trackedAsset =
                        _assetsController.trackedAssets[index];
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Dismissible(
                          key: Key(trackedAsset.name!),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _assetsController.removeAssets(trackedAsset.name!);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: ListTile(
                            leading: Image.network(_assetsController
                                .getAssetImage(trackedAsset.name!)),
                            title: Text(trackedAsset.name!),
                            subtitle: Text(
                                "USD : ${_assetsController.getAssetValue(trackedAsset.name!).toStringAsFixed(2)}"),
                            trailing: Text(trackedAsset.amount.toString()),
                            onTap: () {
                              Get.to(() => DetailView(
                                  coinData: _assetsController
                                      .getCoinData(trackedAsset.name!)!));
                            },
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
