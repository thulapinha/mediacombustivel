
class Transaction {
  final String id;
  final String title;
  final double kmInicial;
  final double kmFinal;
  final double litros;
  final double value;
  final DateTime date;
double get kmTotal => kmFinal - kmInicial;
double get mediaViagem => kmTotal /litros;


  Transaction({
    required this.id,
    required this.title,
    required this.kmInicial,
    required this.kmFinal,
    required this.litros,
    required this.value,
    required this.date,

  });


}
