import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'core/salon_data.dart';
import 'pages/home_page.dart';
import 'pages/reservation_page.dart';

class SalonApp extends StatelessWidget {
  const SalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: SalonData.name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routes: {
        '/': (_) => const HomePage(),
        '/reservation': (_) => const ReservationPage(),
      },
    );
  }
}
