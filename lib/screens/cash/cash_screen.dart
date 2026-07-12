import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cash/add_expense/add_expense_screen.dart';

import '../../providers/reservation_provider.dart';
import '../../providers/cash_provider.dart';

class CashScreen extends StatefulWidget {
  const CashScreen({super.key});

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  DateTime selectedDate = DateTime.now();

  String get formattedDate {
    return "${selectedDate.day.toString().padLeft(2, '0')}."
        "${selectedDate.month.toString().padLeft(2, '0')}."
        "${selectedDate.year}";
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,

      initialDate: selectedDate,

      firstDate: DateTime(2025),

      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationProvider>(context);

    final cashProvider = Provider.of<CashProvider>(context);

    final income = reservationProvider.getDailyIncome(formattedDate);

    final paid = reservationProvider.getDailyPaidIncome(formattedDate);

    final unpaid = reservationProvider.getDailyUnpaidIncome(formattedDate);

    final expense = cashProvider.getDailyExpense(formattedDate);

    final net = paid - expense;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kasa"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_month, color: Colors.green),

                title: Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                trailing: ElevatedButton(
                  child: const Text("Tarih Seç"),

                  onPressed: () {
                    selectDate(context);
                  },
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),

                title: const Text("Alınan Ödeme"),

                trailing: Text("$paid ₺"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.pending, color: Colors.orange),

                title: const Text("Bekleyen Ödeme"),

                trailing: Text("$unpaid ₺"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.remove_circle, color: Colors.red),

                title: const Text("Gider"),

                trailing: Text("$expense ₺"),
              ),
            ),
            Card(
              color: Colors.green.shade100,

              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet),

                title: const Text(
                  "Net Kazanç",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                trailing: Text(
                  "$net ₺",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.green),

                title: const Text("Toplam Gelir"),

                trailing: Text(
                  "$income ₺",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Giderler ($formattedDate)",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),

                label: const Text("Gider Ekle"),

                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => const AddExpenseScreen(),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: cashProvider.getExpensesByDate(formattedDate).length,

                itemBuilder: (context, index) {
                  final expense = cashProvider.getExpensesByDate(
                    formattedDate,
                  )[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),

                      title: Text(expense.title),

                      subtitle: Text("${expense.amount} ₺"),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),

                        onPressed: () {
                          cashProvider.deleteExpense(
                            cashProvider.expenses.indexOf(expense),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
