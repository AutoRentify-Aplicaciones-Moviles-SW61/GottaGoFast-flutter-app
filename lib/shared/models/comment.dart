class Comment {
  final int id;
  final String content;
  final int likes;
  final int carId;
  final String userName;

  Comment({
    required this.id,
    required this.content,
    required this.likes,
    required this.carId,
    required this.userName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    content: json["content"],
    likes: json["likes"],
    carId: json["carId"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "likes": likes,
    "carId": carId,
    "userName": userName,
  };
}