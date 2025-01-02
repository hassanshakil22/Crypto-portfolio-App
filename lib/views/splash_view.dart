import 'package:crypto_app/global/utils.dart';
import 'package:crypto_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  initState() {
    super.initState();
    splash();
  }

  Future splash() async {
    await registerServices();
    await registerControllers();
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(() => HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.3,
          width: MediaQuery.sizeOf(context).width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: const DecorationImage(
              image: AssetImage('assets/splash.webp'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
