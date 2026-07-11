import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/reservation_provider.dart';
import '../../models/reservation_model.dart';
import '../reservation/add_reservation/add_reservation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String get formattedDate {
    final now = DateTime.now();

    return "${now.day.toString().padLeft(2, '0')}."
        "${now.month.toString().padLeft(2, '0')}."
        "${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProvider>(context);

    final reservations =
        provider.getReservationsByDate(formattedDate);

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

            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 20),


            Expanded(
              child: ListView.builder(

                itemCount: provider.workingHours.length,

                itemBuilder: (context,index){

                  final time =
                      provider.workingHours[index];


                  final reservation =
                      provider.getReservationByTime(
                        formattedDate,
                        time,
                      );


                  return Card(

                    child: ListTile(

                      leading: Icon(
                        Icons.sports_soccer,

                        color: reservation == null
                            ? Colors.green
                            : Colors.red,
                      ),


                      title: Text(time),


                      trailing: Text(

                        reservation == null
                            ? "Boş"
                            : reservation.customerName,

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),

                      ),

                    ),

                  );

                },

              ),
            ),



            const Divider(),



            const Text(
              "Bugünkü Gelir",

              style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.bold,
              ),

            ),



            Text(

              "${_calculateIncome(reservations)} TL",

              style: const TextStyle(
                fontSize:30,
                color:Colors.green,
                fontWeight:FontWeight.bold,
              ),

            ),



            const SizedBox(height:10),



            SizedBox(

              width:double.infinity,


              child: ElevatedButton(

                onPressed: (){


                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:(context)=>
                          const AddReservationScreen(),

                    ),

                  );


                },


                child:
                const Text(
                  "➕ Yeni Rezervasyon",
                ),

              ),

            ),


          ],

        ),

      ),

    );

  }



  int _calculateIncome(
      List<Reservation> reservations
      ){

    int total = 0;


    for(final reservation in reservations){

      if(reservation.isPaid){

        total += reservation.price;

      }

    }


    return total;

  }


}