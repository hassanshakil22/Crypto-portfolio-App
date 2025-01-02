import 'package:crypto_app/global/utils.dart';
import 'package:crypto_app/views/home_view.dart';
import 'package:crypto_app/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        "/splash": (context) => SplashView(),
      },
      initialRoute: "/splash",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          textTheme: GoogleFonts.sansitaTextTheme()),
    );
  }
}
