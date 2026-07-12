import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/reservation_model.dart';

class ReservationProvider extends ChangeNotifier {
  final List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  final List<String> workingHours = [
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
    "21:00 - 22:00",
    "22:00 - 23:00",
    "23:00 - 00:00",
  ];

  ReservationProvider() {
    loadReservations();
  }

  // Kayıtları yükle

  Future<void> loadReservations() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("reservations");

    if (data != null) {
      final List decoded = jsonDecode(data);

      _reservations.clear();

      _reservations.addAll(decoded.map((item) => Reservation.fromJson(item)));

      notifyListeners();
    }
  }

  // Kayıtları telefona yaz

  Future<void> saveReservations() async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(
      _reservations.map((reservation) => reservation.toJson()).toList(),
    );

    await prefs.setString("reservations", data);
  }

  // Rezervasyon ekleme

  Future<void> addReservation(Reservation reservation) async {
    _reservations.add(reservation);

    await saveReservations();

    notifyListeners();
  }

  // Silme

  Future<void> deleteReservation(int index) async {
    _reservations.removeAt(index);

    await saveReservations();

    notifyListeners();
  }

  // Güncelleme

  Future<void> updateReservation(int index, Reservation reservation) async {
    _reservations[index] = reservation;

    await saveReservations();

    notifyListeners();
  }

  // Saat ve tarih bulma

  Reservation? getReservationByTime(String date, String time) {
    try {
      return _reservations.firstWhere(
        (reservation) => reservation.date == date && reservation.time == time,
      );
    } catch (e) {
      return null;
    }
  }

  // Belirli gün rezervasyonları

  List<Reservation> getReservationsByDate(String date) {
    return _reservations
        .where((reservation) => reservation.date == date)
        .toList();
  }

  // Günlük toplam gelir

  int getDailyIncome(String date) {
    return _reservations
        .where((reservation) => reservation.date == date)
        .fold(0, (sum, reservation) => sum + reservation.price);
  }

  // Günlük rezervasyon sayısı

  int getDailyReservationCount(String date) {
    return _reservations
        .where((reservation) => reservation.date == date)
        .length;
  }
  // Günlük doluluk oranı

  int getDailyOccupancy(String date) {
    final totalHours = workingHours.length;

    if (totalHours == 0) {
      return 0;
    }

    final reservedHours = getDailyReservationCount(date);

    return ((reservedHours / totalHours) * 100).round();
  }
  // Günlük alınan ödeme

  int getDailyPaidIncome(String date) {
    return _reservations
        .where((reservation) => reservation.date == date && reservation.isPaid)
        .fold(0, (sum, reservation) => sum + reservation.price);
  }

  // Günlük bekleyen ödeme

  int getDailyUnpaidIncome(String date) {
    return _reservations
        .where((reservation) => reservation.date == date && !reservation.isPaid)
        .fold(0, (sum, reservation) => sum + reservation.price);
  }
}
