import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/reservation_provider.dart';
import '../reservation/add_reservation/add_reservation_screen.dart';
import '../reservation/edit_reservation/edit_reservation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String get displayDate {
    final now = DateTime.now();
    return DateFormat("dd MMMM yyyy EEEE", "tr_TR").format(now);
  }

  String get formattedDate {
    final now = DateTime.now();

    return "${now.day.toString().padLeft(2, '0')}."
        "${now.month.toString().padLeft(2, '0')}."
        "${now.year}";
  }


  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ReservationProvider>(context);


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
              displayDate,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 15),



            Card(

              elevation: 4,

              child: Padding(

                padding: const EdgeInsets.all(16),


                child: Column(

                  children: [


                    const Text(
                      "Bugünkü Özet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 15),



                    Row(

                      children: [


                        Expanded(

                          child: Container(

                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),


                            child: Column(

                              children: [

                                const Icon(
                                  Icons.sports_soccer,
                                  color: Colors.green,
                                ),


                                Text(
                                  "${provider.getDailyReservationCount(formattedDate)}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                                const Text("Maç"),


                                Text(
                                  "Doluluk: ${provider.getDailyOccupancy(formattedDate)}%",
                                ),

                              ],

                            ),

                          ),

                        ),



                        const SizedBox(width: 10),




                        Expanded(

                          child: Container(

                            padding: const EdgeInsets.all(12),


                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),


                            child: Column(

                              children: [


                                const Icon(
                                  Icons.attach_money,
                                  color: Colors.orange,
                                ),



                                Text(

                                  "${provider.getDailyIncome(formattedDate)} ₺",

                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),



                                const Text("Kazanç"),



                                const SizedBox(height: 8),



                                Text(
                                  "✅ Alınan: ${provider.getDailyPaidIncome(formattedDate)} ₺",
                                ),



                                Text(
                                  "⏳ Bekleyen: ${provider.getDailyUnpaidIncome(formattedDate)} ₺",
                                ),


                              ],

                            ),

                          ),

                        ),


                      ],

                    ),


                  ],

                ),

              ),

            ),




            const SizedBox(height: 20),





            Expanded(

              child: ListView.builder(


                itemCount: provider.workingHours.length,


                itemBuilder: (context,index){


                  final time = provider.workingHours[index];


                  final reservation =
                      provider.getReservationByTime(
                        formattedDate,
                        time,
                      );



                  return Card(


                    child: ListTile(


                      onTap: (){


                        if(reservation == null){


                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  AddReservationScreen(
                                    selectedTime: time,
                                  ),
                            ),
                          );


                        }else{


                          showDialog(

                            context: context,

                            builder: (_) => AlertDialog(

                              title: const Text(
                                "Rezervasyon Detayı",
                              ),


                              content: Column(

                                mainAxisSize:
                                    MainAxisSize.min,


                                crossAxisAlignment:
                                    CrossAxisAlignment.start,


                                children: [


                                  Text(
                                    "Müşteri: ${reservation.customerName}",
                                  ),


                                  Text(
                                    "Telefon: ${reservation.phone}",
                                  ),


                                  Text(
                                    "Saat: ${reservation.time}",
                                  ),


                                  Text(
                                    "Ücret: ${reservation.price} ₺",
                                  ),


                                ],

                              ),


                              actions: [


                                TextButton(

                                  onPressed: (){


                                    Navigator.pop(context);


                                    Navigator.push(

                                      context,

                                      MaterialPageRoute(

                                        builder: (_) =>
                                            EditReservationScreen(

                                              reservation:
                                                  reservation,


                                              index: provider
                                                  .reservations
                                                  .indexOf(
                                                    reservation,
                                                  ),

                                            ),

                                      ),

                                    );


                                  },

                                  child: const Text("Düzenle"),

                                ),




                                TextButton(

                                  onPressed: (){


                                    provider.deleteReservation(

                                      provider.reservations
                                          .indexOf(
                                            reservation,
                                          ),

                                    );


                                    Navigator.pop(context);


                                  },


                                  child: const Text("Sil"),

                                ),



                              ],

                            ),

                          );

                        }


                      },




                      leading: Icon(

                        Icons.sports_soccer,

                        color: reservation == null
                            ? Colors.green
                            : Colors.red,

                      ),




                      title: Text(time),




                      subtitle: Text(

                        reservation == null
                            ? "Müsait"
                            : reservation.phone,

                      ),





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



          ],

        ),

      ),


    );

  }

}