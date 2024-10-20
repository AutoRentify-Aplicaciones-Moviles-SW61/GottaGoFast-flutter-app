class User {
  String id;
  String email;
  String password;
  String? name;
  String? bio;
  String? profilePictureUrl;

  User({
    required this.id,
    required this.email,
    required this.password,
    this.name,
    this.bio,
    this.profilePictureUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}