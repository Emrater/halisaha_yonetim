import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/expense_model.dart';
import '../../../providers/cash_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  String get today {
    final now = DateTime.now();

    return "${now.day.toString().padLeft(2, '0')}."
        "${now.month.toString().padLeft(2, '0')}."
        "${now.year}";
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gider Ekle")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: titleController,

              decoration: const InputDecoration(
                labelText: "Gider Açıklaması",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: amountController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Tutar",

                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty ||
                      amountController.text.isEmpty) {
                    return;
                  }

                  final expense = Expense(
                    date: today,

                    title: titleController.text,

                    amount: int.tryParse(amountController.text) ?? 0,
                  );

                  final provider = Provider.of<CashProvider>(
                    context,
                    listen: false,
                  );

                  provider.addExpense(expense);

                  if (!mounted) return;

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
