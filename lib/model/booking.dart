class BookingVm {
  final String? id;
  final String userId;
  final String trainId;
  final bool isCanceled;
  final bool canCancel;
  final DateTime date;

  BookingVm({
    this.id,
    required this.userId,
    required this.trainId,
    required this.isCanceled,
    required this.canCancel,
    required this.date,
  });
}

class MyBooking {
  final String id;
  final String userId;
  final bool isCanceled;
  final bool canCancel;
  final DateTime bookingDate;
  final DateTime trainDate;
  final String from;
  final String to;
  final int price;
  final String category;
  final String time;
  final String trainNumber;

  MyBooking({
    required this.id,
    required this.userId,
    required this.isCanceled,
    required this.canCancel,
    required this.bookingDate,
    required this.trainDate,
    required this.from,
    required this.to,
    required this.price,
    required this.category,
    required this.time,
    required this.trainNumber,
  });
}
