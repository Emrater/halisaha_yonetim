class Reservation {


  final String date;

  final String time;

  final String customerName;

  final String phone;

  final int price;

  final bool isPaid;



  const Reservation({

    required this.date,

    required this.time,

    required this.customerName,

    required this.phone,

    required this.price,

    required this.isPaid,

  });

}