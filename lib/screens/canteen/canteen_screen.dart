import 'package:flutter/material.dart';

class CanteenScreen extends StatelessWidget {
  const CanteenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kantin"),
      ),
      body: const Center(
        child: Text(
          "Kantin ekranı",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}