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

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "time": time,
      "customerName": customerName,
      "phone": phone,
      "price": price,
      "isPaid": isPaid,
    };
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      date: json["date"],
      time: json["time"],
      customerName: json["customerName"],
      phone: json["phone"],
      price: json["price"],
      isPaid: json["isPaid"],
    );
  }
}