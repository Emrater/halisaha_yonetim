import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gebze Maxi Halısaha"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "11 Temmuz 2026",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildReservation("16:00", "Boş"),
            _buildReservation("17:00", "Boş"),
            _buildReservation("18:00", "Ahmet"),
            _buildReservation("19:00", "Tayfunspor"),
            _buildReservation("20:00", "Boş"),

            const Spacer(),

            const Divider(),

            const Text(
              "Bugünkü Gelir",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "0 TL",
              style: TextStyle(
                fontSize: 30,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("➕ Yeni Rezervasyon"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservation(String saat, String isim) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.sports_soccer),
        title: Text(saat),
        trailing: Text(
          isim,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}