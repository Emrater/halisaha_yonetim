import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense_model.dart';


class CashProvider extends ChangeNotifier {


  final List<Expense> _expenses = [];


  List<Expense> get expenses => _expenses;



  CashProvider(){

    loadExpenses();

  }




  // Giderleri yükle

  Future<void> loadExpenses() async {


    final prefs = await SharedPreferences.getInstance();


    final data = prefs.getString("expenses");



    if(data != null){


      final List decoded = jsonDecode(data);


      _expenses.clear();


      _expenses.addAll(

        decoded.map(

          (item)=> Expense.fromJson(item),

        ),

      );


      notifyListeners();

    }

  }





  // Kaydet

  Future<void> saveExpenses() async {


    final prefs = await SharedPreferences.getInstance();



    final data = jsonEncode(

      _expenses.map(

        (expense)=> expense.toJson(),

      ).toList(),

    );



    await prefs.setString(
      "expenses",
      data,
    );


  }





  // Gider ekle

  Future<void> addExpense(
      Expense expense
  ) async {


    _expenses.add(expense);


    await saveExpenses();


    notifyListeners();


  }





  // Gider sil

  Future<void> deleteExpense(
      int index
  ) async {


    _expenses.removeAt(index);


    await saveExpenses();


    notifyListeners();


  }





  // Günlük gider toplamı

  int getDailyExpense(String date){


    return _expenses

        .where(
          (expense)=> expense.date == date,
        )

        .fold(
          0,
          (sum, expense)=> sum + expense.amount,
        );


  }



  // Günlük gider listesi

  List<Expense> getExpensesByDate(
      String date
  ){


    return _expenses

        .where(
          (expense)=> expense.date == date,
        )

        .toList();


  }


}