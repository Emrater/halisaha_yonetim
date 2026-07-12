import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/reservation_provider.dart';
import '../../providers/cash_provider.dart';


class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});


  String get today {

    final now = DateTime.now();

    return "${now.day.toString().padLeft(2,'0')}."
        "${now.month.toString().padLeft(2,'0')}."
        "${now.year}";
  }



  @override
  Widget build(BuildContext context) {


    final reservationProvider =
        Provider.of<ReservationProvider>(context);


    final cashProvider =
        Provider.of<CashProvider>(context);



    final totalMatch =
        reservationProvider.getDailyReservationCount(today);


    final income =
        reservationProvider.getDailyIncome(today);


    final paid =
        reservationProvider.getDailyPaidIncome(today);


    final unpaid =
        reservationProvider.getDailyUnpaidIncome(today);


    final expense =
        cashProvider.getDailyExpense(today);


    final net =
        paid - expense;



    return Scaffold(


      appBar: AppBar(

        title: const Text("Günlük Rapor"),

        backgroundColor: Colors.green,

        foregroundColor: Colors.white,

      ),



      body: Padding(

        padding: const EdgeInsets.all(16),


        child: Column(

          children: [


            Card(

              child: ListTile(

                leading: const Icon(
                  Icons.sports_soccer,
                  color: Colors.green,
                ),

                title: const Text(
                  "Toplam Maç",
                ),

                trailing: Text(
                  "$totalMatch",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),

            ),



            Card(

              child: ListTile(

                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),

                title: const Text(
                  "Toplam Gelir",
                ),

                trailing: Text(
                  "$income ₺",
                ),

              ),

            ),



            Card(

              child: ListTile(

                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),

                title: const Text(
                  "Alınan Para",
                ),

                trailing: Text(
                  "$paid ₺",
                ),

              ),

            ),



            Card(

              child: ListTile(

                leading: const Icon(
                  Icons.pending,
                  color: Colors.orange,
                ),

                title: const Text(
                  "Bekleyen Para",
                ),

                trailing: Text(
                  "$unpaid ₺",
                ),

              ),

            ),



            Card(

              child: ListTile(

                leading: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),

                title: const Text(
                  "Gider",
                ),

                trailing: Text(
                  "$expense ₺",
                ),

              ),

            ),



            Card(

              color: Colors.green.shade100,


              child: ListTile(

                leading: const Icon(
                  Icons.account_balance_wallet,
                ),

                title: const Text(
                  "Net Kazanç",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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


          ],

        ),

      ),


    );

  }

}