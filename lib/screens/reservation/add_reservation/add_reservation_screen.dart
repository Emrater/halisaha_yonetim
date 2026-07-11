import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/reservation_provider.dart';

class AddReservationScreen extends StatefulWidget {
  const AddReservationScreen({super.key});

  @override
  State<AddReservationScreen> createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {
  DateTime selectedDate = DateTime.now();

  String selectedTime = "16:00";

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final priceController = TextEditingController();

  bool isPaid = false;

  final List<String> times = [
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
  ];

  String get formattedDate {
    return DateFormat("dd.MM.yyyy").format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Rezervasyon")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_month, color: Colors.green),

              title: Text(formattedDate),

              trailing: ElevatedButton(
                child: const Text("Tarih Seç"),

                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,

                    initialDate: selectedDate,

                    firstDate: DateTime(2026),

                    lastDate: DateTime(2030),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedTime,

              decoration: const InputDecoration(
                labelText: "Saat",

                border: OutlineInputBorder(),
              ),

              items: times.map((time) {
                return DropdownMenuItem(value: time, child: Text(time));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedTime = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                labelText: "Müşteri Adı",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,

              keyboardType: TextInputType.phone,

              decoration: const InputDecoration(
                labelText: "Telefon",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: priceController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Ücret",

                border: OutlineInputBorder(),
              ),
            ),

            CheckboxListTile(
              title: const Text("Ödeme Alındı"),

              value: isPaid,

              onChanged: (value) {
                setState(() {
                  isPaid = value!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Müşteri adı giriniz")),
                    );

                    return;
                  }

                  final provider = Provider.of<ReservationProvider>(
                    context,
                    listen: false,
                  );

                  final existing = provider.getReservationByTime(
                    formattedDate,
                    selectedTime,
                  );

                  if (existing != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Bu saat dolu!")),
                    );

                    return;
                  }

                  final reservation = Reservation(
                    date: formattedDate,

                    time: selectedTime,

                    customerName: nameController.text,

                    phone: phoneController.text,

                    price: int.tryParse(priceController.text) ?? 0,

                    isPaid: isPaid,
                  );

                  provider.addReservation(reservation);

                  Navigator.pop(context);
                },

                child: const Text("Kaydet"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
