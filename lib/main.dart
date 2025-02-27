import 'package:app/screens/test/button_test_screen.dart';
import 'package:flutter/material.dart';
// import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';
// import 'test_services.dart';

void main() {
  // // For testing services
  // testRidesService();

  // Run the actual app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      // home: const Scaffold(body: RidePrefScreen()),
      home: const ButtonTestScreen(),
    );
  }
}
