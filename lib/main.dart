import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/reservation_provider.dart';
import 'screens/main_navigation/main_navigation_screen.dart';


void main() {
  runApp(const HalisahaApp());
}


class HalisahaApp extends StatelessWidget {
  const HalisahaApp({super.key});


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (_) => ReservationProvider(),

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        title: 'Halısaha Yönetim',

        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),

          useMaterial3: true,

        ),

        home: const MainNavigationScreen(),

      ),

    );

  }
}