import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/reservation_provider.dart';

class AddReservationScreen extends StatefulWidget {
  final String? selectedTime;

  const AddReservationScreen({
    super.key,
    this.selectedTime,
  });

  @override
  State<AddReservationScreen> createState() =>
      _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {

  DateTime selectedDate = DateTime.now();

  late String selectedTime;


  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final priceController = TextEditingController();


  bool isPaid = false;


  @override
  void initState() {
    super.initState();

    selectedTime =
        widget.selectedTime ?? "08:00 - 09:00";
  }


  String get formattedDate {

    return DateFormat("dd.MM.yyyy")
        .format(selectedDate);

  }


  @override
  void dispose() {

    nameController.dispose();
    phoneController.dispose();
    priceController.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {


    final provider =
        Provider.of<ReservationProvider>(context);



    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Yeni Rezervasyon",
        ),
      ),



      body: Padding(

        padding: const EdgeInsets.all(16),


        child: Column(

          children: [



            ListTile(

              leading: const Icon(
                Icons.calendar_month,
                color: Colors.green,
              ),


              title: Text(
                formattedDate,
              ),


              trailing: ElevatedButton(

                child: const Text(
                  "Tarih Seç",
                ),


                onPressed: () async {


                  DateTime? picked =
                      await showDatePicker(

                    context: context,

                    initialDate: selectedDate,

                    firstDate: DateTime.now(),

                    lastDate:
                        DateTime.now()
                            .add(
                              const Duration(
                                days: 365,
                              ),
                            ),

                  );


                  if (picked != null) {

                    setState(() {

                      selectedDate = picked;

                    });

                  }


                },

              ),

            ),



            const SizedBox(
              height: 15,
            ),




            DropdownButtonFormField<String>(


              initialValue:
                  provider.workingHours
                          .contains(selectedTime)
                      ? selectedTime
                      : null,


              decoration:
                  const InputDecoration(

                labelText: "Saat",

                border:
                    OutlineInputBorder(),

              ),



              items:
                  provider.workingHours
                      .map((time) {


                return DropdownMenuItem<String>(

                  value: time,

                  child: Text(time),

                );


              }).toList(),




              onChanged: (value) {


                setState(() {

                  selectedTime = value!;

                });


              },


            ),




            const SizedBox(
              height: 15,
            ),




            TextField(

              controller: nameController,

              decoration:
                  const InputDecoration(

                labelText:
                    "Müşteri Adı",

                border:
                    OutlineInputBorder(),

              ),

            ),




            const SizedBox(
              height: 15,
            ),




            TextField(

              controller: phoneController,

              keyboardType:
                  TextInputType.phone,


              decoration:
                  const InputDecoration(

                labelText:
                    "Telefon",

                border:
                    OutlineInputBorder(),

              ),

            ),




            const SizedBox(
              height: 15,
            ),




            TextField(

              controller: priceController,


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


              value: isPaid,


              onChanged: (value) {


                setState(() {

                  isPaid = value!;

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


                onPressed: () {



                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty) {


                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content:
                            Text(
                              "Müşteri adı ve telefon giriniz",
                            ),

                      ),

                    );


                    return;

                  }




                  final existing =
                      provider.getReservationByTime(

                    formattedDate,

                    selectedTime,

                  );




                  if (existing != null) {


                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content:
                            Text(
                              "Bu saat dolu!",
                            ),

                      ),

                    );


                    return;


                  }





                  final reservation =
                      Reservation(

                    date:
                        formattedDate,


                    time:
                        selectedTime,


                    customerName:
                        nameController.text,


                    phone:
                        phoneController.text,


                    price:
                        int.tryParse(
                              priceController.text,
                            ) ??
                            500,


                    isPaid:
                        isPaid,


                  );





                  provider.addReservation(
                    reservation,
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