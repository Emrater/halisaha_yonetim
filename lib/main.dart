import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'providers/reservation_provider.dart';
import 'providers/cash_provider.dart';

import 'screens/main_navigation/main_navigation_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('tr_TR', null);

  runApp(
    const HalisahaApp(),
  );

}



class HalisahaApp extends StatelessWidget {

  const HalisahaApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => ReservationProvider(),
        ),


        ChangeNotifierProvider(
          create: (_) => CashProvider(),
        ),

      ],


      child: MaterialApp(

        debugShowCheckedModeBanner: false,


        title: "Halısaha Yönetim",


        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),


          useMaterial3: true,

        ),


        home: const MainNavigationScreen(),

      ),

    );

  }

}