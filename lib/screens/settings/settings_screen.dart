import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Ayarlar",
        ),

        centerTitle: true,

      ),


      body: const Center(

        child: Text(
          "Ayarlar Sayfası",
          style: TextStyle(
            fontSize: 22,
          ),
        ),

      ),

    );

  }

}