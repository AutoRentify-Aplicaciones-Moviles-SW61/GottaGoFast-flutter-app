class PaymentMethod {
  final int id;
  final String type;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final int userId;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.userId,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    type: json["type"],
    cardNumber: json["cardNumber"],
    expiryDate: json["expiryDate"],
    cardHolderName: json["cardHolderName"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "cardNumber": cardNumber,
    "expiryDate": expiryDate,
    "cardHolderName": cardHolderName,
    "userId": userId, 
  };
}