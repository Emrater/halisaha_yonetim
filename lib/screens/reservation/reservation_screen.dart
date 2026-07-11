import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/reservation_provider.dart';
import '../../models/reservation_model.dart';
import 'add_reservation/add_reservation_screen.dart';



class ReservationScreen extends StatefulWidget {

  const ReservationScreen({super.key});


  @override
  State<ReservationScreen> createState() =>
      _ReservationScreenState();

}



class _ReservationScreenState extends State<ReservationScreen> {


  DateTime selectedDate = DateTime.now();



  String get formattedDate {

    return
        "${selectedDate.day.toString().padLeft(2,'0')}."
        "${selectedDate.month.toString().padLeft(2,'0')}."
        "${selectedDate.year}";

  }





  @override
  Widget build(BuildContext context) {


    final provider =
    Provider.of<ReservationProvider>(context);



    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Rezervasyonlar",
        ),

        centerTitle: true,

      ),




      body: Column(


        children: [



          Row(

            mainAxisAlignment:
            MainAxisAlignment.center,


            children: [



              IconButton(

                icon:
                const Icon(
                  Icons.arrow_back,
                ),


                onPressed: (){


                  setState(() {


                    selectedDate =
                        selectedDate.subtract(
                          const Duration(days:1),
                        );


                  });


                },


              ),





              Text(

                formattedDate,

                style:
                const TextStyle(

                  fontSize:20,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),





              IconButton(

                icon:
                const Icon(
                  Icons.arrow_forward,
                ),


                onPressed: (){


                  setState(() {


                    selectedDate =
                        selectedDate.add(
                          const Duration(days:1),
                        );


                  });


                },


              ),



            ],

          ),





          Expanded(


            child:

            ListView.builder(


              itemCount:
              provider.workingHours.length,



              itemBuilder:
                  (context,index){



                final time =
                provider.workingHours[index];



                Reservation? reservation =
                provider.getReservationByTime(
                  formattedDate,
                  time,
                );




                bool isEmpty =
                    reservation == null;




                return Card(


                  margin:
                  const EdgeInsets.all(8),



                  child:

                  ListTile(



                    leading:

                    Icon(

                      Icons.sports_soccer,

                      color:

                      isEmpty
                          ? Colors.green
                          : Colors.red,

                    ),




                    title:

                    Text(

                      time,

                      style:
                      const TextStyle(

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),




                    subtitle:

                    Text(

                      isEmpty

                          ? "Müsait"

                          :

                      "${reservation.customerName} - ${reservation.phone}",

                    ),




                    trailing:

                    Text(

                      isEmpty

                          ? ""

                          :

                      "${reservation.price} TL",

                      style:
                      const TextStyle(

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),



                  ),



                );


              },


            ),


          ),



        ],


      ),




      floatingActionButton:

      FloatingActionButton(

        child:
        const Icon(
          Icons.add,
        ),


        onPressed: (){


          Navigator.push(

            context,

            MaterialPageRoute(

              builder:(context)=>

              const AddReservationScreen(),

            ),

          );


        },

      ),



    );


  }


}