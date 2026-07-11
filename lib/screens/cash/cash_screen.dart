import 'package:flutter/material.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kasa"),
      ),
      body: const Center(
        child: Text(
          "Kasa ekranı",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}