import 'package:flutter/material.dart';
import '../models/reservation_model.dart';


class ReservationProvider extends ChangeNotifier {


  final List<Reservation> _reservations = [];



  List<Reservation> get reservations => _reservations;



  // Rezervasyon ekleme

  void addReservation(Reservation reservation) {

    _reservations.add(reservation);

    notifyListeners();

  }





  // Rezervasyon silme

  void deleteReservation(int index) {

    _reservations.removeAt(index);

    notifyListeners();

  }





  // Rezervasyon güncelleme

  void updateReservation(
      int index,
      Reservation reservation,
      ) {


    _reservations[index] = reservation;

    notifyListeners();

  }






  // Çalışma saatleri

  final List<String> workingHours = [


    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",


  ];







  // Belirli tarih ve saatte rezervasyon var mı?

  Reservation? getReservationByTime(
      String date,
      String time,
      ) {


    try {


      return _reservations.firstWhere(


            (reservation) =>

        reservation.date == date &&

            reservation.time == time,


      );



    } catch(e) {


      return null;


    }


  }







  // Belirli güne ait rezervasyonlar

  List<Reservation> getReservationsByDate(
      String date,
      ) {


    return _reservations
        .where(

          (reservation) =>

      reservation.date == date,

    )

        .toList();


  }




}