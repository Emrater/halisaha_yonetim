import 'package:flutter/material.dart';

import '../report/report_screen.dart';
import '../home/home_screen.dart';
import '../reservation/reservation_screen.dart';
import '../canteen/canteen_screen.dart';
import '../cash/cash_screen.dart';
import '../settings/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    ReservationScreen(),
    CanteenScreen(),
    CashScreen(),
    ReportScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Ana Sayfa"),

          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "Rezervasyon",
          ),

          NavigationDestination(icon: Icon(Icons.local_cafe), label: "Kantin"),

          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: "Kasa",
          ),

          NavigationDestination(icon: Icon(Icons.bar_chart), label: "Rapor"),

          NavigationDestination(icon: Icon(Icons.settings), label: "Ayarlar"),
        ],
      ),
    );
  }
}
