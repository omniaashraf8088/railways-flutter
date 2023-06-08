class ITrain {
  final String id;
  final String name;
  final int price;
  final String category;
  final String from;
  final String to;
  final DateTime date;
  final String time;
  final int standStations;
  final int availableSeats;
  ITrain({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.standStations,
    required this.availableSeats,
  });
}
