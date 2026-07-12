class Expense {

  final String date;
  final String title;
  final int amount;


  Expense({
    required this.date,
    required this.title,
    required this.amount,
  });



  Map<String,dynamic> toJson(){

    return {

      "date": date,
      "title": title,
      "amount": amount,

    };

  }



  factory Expense.fromJson(Map<String,dynamic> json){

    return Expense(

      date: json["date"],

      title: json["title"],

      amount: json["amount"],

    );

  }

}