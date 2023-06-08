class ICard {
  final String id;
  final String userId;
  final String userName;
  final String cardNumber;
  final String date;
  final String cvv;

  ICard({
    required this.id,
    required this.userId,
    required this.userName,
    required this.cardNumber,
    required this.date,
    required this.cvv,
  });
}
