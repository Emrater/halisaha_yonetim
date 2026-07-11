import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/reservation_provider.dart';


class EditReservationScreen extends StatefulWidget {

  final Reservation reservation;
  final int index;


  const EditReservationScreen({

    super.key,

    required this.reservation,

    required this.index,

  });



  @override
  State<EditReservationScreen> createState() =>
      _EditReservationScreenState();

}




class _EditReservationScreenState
    extends State<EditReservationScreen> {



  late TextEditingController dateController;

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController priceController;



  late String selectedTime;


  late bool isPaid;



  final List<String> times = [

    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",

  ];




  @override
  void initState() {

    super.initState();


    dateController =
        TextEditingController(
          text: widget.reservation.date,
        );


    nameController =
        TextEditingController(
          text: widget.reservation.customerName,
        );


    phoneController =
        TextEditingController(
          text: widget.reservation.phone,
        );


    priceController =
        TextEditingController(
          text: widget.reservation.price.toString(),
        );


    selectedTime =
        widget.reservation.time;


    isPaid =
        widget.reservation.isPaid;


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text("Rezervasyon Düzenle"),

      ),



      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(


          children: [



            TextField(

              controller:
                  dateController,


              decoration:
                  const InputDecoration(

                labelText: "Tarih",

                border:
                    OutlineInputBorder(),

              ),

            ),




            const SizedBox(height: 15),




            DropdownButtonFormField<String>(


              value:
                  selectedTime,


              decoration:
                  const InputDecoration(

                labelText: "Saat",

                border:
                    OutlineInputBorder(),

              ),



              items:
                  times.map((time){


                return DropdownMenuItem(

                  value:
                      time,


                  child:
                      Text(time),

                );


              }).toList(),



              onChanged: (value){


                setState(() {


                  selectedTime =
                      value!;


                });


              },


            ),




            const SizedBox(height: 15),




            TextField(

              controller:
                  nameController,


              decoration:
                  const InputDecoration(

                labelText:
                    "Müşteri Adı",

                border:
                    OutlineInputBorder(),

              ),

            ),




            const SizedBox(height: 15),




            TextField(

              controller:
                  phoneController,


              decoration:
                  const InputDecoration(

                labelText:
                    "Telefon",

                border:
                    OutlineInputBorder(),

              ),

            ),




            const SizedBox(height: 15),




            TextField(

              controller:
                  priceController,


              keyboardType:
                  TextInputType.number,


              decoration:
                  const InputDecoration(

                labelText:
                    "Ücret",

                border:
                    OutlineInputBorder(),

              ),

            ),





            CheckboxListTile(

              title:
                  const Text(
                    "Ödeme Alındı",
                  ),


              value:
                  isPaid,


              onChanged: (value){


                setState(() {


                  isPaid =
                      value!;


                });


              },


            ),




            const Spacer(),




            SizedBox(

              width:
                  double.infinity,


              height:
                  50,



              child:
                  ElevatedButton(



                onPressed: (){



                  final updated =
                      Reservation(


                    date:
                        dateController.text,


                    time:
                        selectedTime,


                    customerName:
                        nameController.text,


                    phone:
                        phoneController.text,


                    price:
                        int.tryParse(
                          priceController.text,
                        ) ?? 0,


                    isPaid:
                        isPaid,



                  );



                  Provider.of<ReservationProvider>(

                    context,

                    listen:false,


                  ).updateReservation(

                    widget.index,

                    updated,

                  );



                  Navigator.pop(context);



                },



                child:
                    const Text(
                      "Kaydet",
                    ),


              ),

            ),



          ],

        ),

      ),

    );


  }



}