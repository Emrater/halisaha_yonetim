import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/reservation_provider.dart';


class CalendarScreen extends StatefulWidget {

  const CalendarScreen({super.key});


  @override
  State<CalendarScreen> createState() =>
      _CalendarScreenState();

}



class _CalendarScreenState extends State<CalendarScreen> {


  DateTime selectedDate = DateTime.now();



  String get formattedDate {

    return DateFormat("dd.MM.yyyy")
        .format(selectedDate);

  }



  String get displayDate {

    return DateFormat(
      "dd MMMM yyyy",
      "tr_TR",
    ).format(selectedDate);

  }



  @override
  Widget build(BuildContext context) {


    final provider =
        Provider.of<ReservationProvider>(context);



    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Gelir Raporu",
        ),

        backgroundColor: Colors.green,

        foregroundColor: Colors.white,

      ),



      body: Padding(

        padding: const EdgeInsets.all(16),


        child: Column(

          children: [


            Card(

              child: ListTile(

                leading:
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.green,
                    ),


                title:
                    Text(displayDate),


                trailing:
                    ElevatedButton(

                  child:
                      const Text(
                        "Değiştir",
                      ),


                  onPressed: () async {


                    final picked =
                        await showDatePicker(

                      context: context,

                      initialDate:
                          selectedDate,

                      firstDate:
                          DateTime(2025),

                      lastDate:
                          DateTime.now()
                              .add(
                                const Duration(
                                  days: 365,
                                ),
                              ),

                    );


                    if(picked != null){

                      setState(() {

                        selectedDate = picked;

                      });

                    }


                  },

                ),

              ),

            ),



            const SizedBox(height:20),



            Card(

              elevation:4,


              child: Padding(

                padding:
                    const EdgeInsets.all(20),


                child: Column(

                  children: [


                    Text(
                      "Toplam Maç",
                      style:
                          const TextStyle(
                            fontSize:18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                    ),


                    Text(

                      "${provider.getDailyReservationCount(formattedDate)}",

                      style:
                          const TextStyle(
                            fontSize:30,
                            fontWeight:
                                FontWeight.bold,
                          ),

                    ),



                    const Divider(),



                    Text(
                      "Toplam Gelir",
                    ),


                    Text(

                      "${provider.getDailyIncome(formattedDate)} ₺",

                      style:
                          const TextStyle(
                            fontSize:26,
                            color:Colors.green,
                            fontWeight:
                                FontWeight.bold,
                          ),

                    ),



                    const SizedBox(height:10),



                    Text(
                      "Alınan: ${provider.getDailyPaidIncome(formattedDate)} ₺",
                    ),



                    Text(
                      "Bekleyen: ${provider.getDailyUnpaidIncome(formattedDate)} ₺",
                    ),



                    const SizedBox(height:10),



                    Text(
                      "Doluluk: ${provider.getDailyOccupancy(formattedDate)}%",
                    ),


                  ],

                ),

              ),

            ),


          ],

        ),

      ),

    );

  }

}