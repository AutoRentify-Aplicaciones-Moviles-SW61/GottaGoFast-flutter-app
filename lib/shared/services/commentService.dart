import 'package:app_tentify_frfr/shared/models/comment.dart';

class CommentService {
  static final CommentService _instance = CommentService._internal();
  List<Comment> _comments = [];

  factory CommentService() {
    return _instance;
  }

  CommentService._internal() {
    _comments.add(Comment(
      id: 1,
      content: "Great car!",
      likes: 5,
      carId: 1,
      userName: "John Doe",
    ));
    _comments.add(Comment(
      id: 2,
      content: "Needs some work.",
      likes: 2,
      carId: 1,
      userName: "Jane Smith",
    ));
    _comments.add(Comment(
      id: 3,
      content: "Is this Batmobile 2.0?",
      likes: 10,
      carId: 1,
      userName: "Bruce W.",
    ));
    _comments.add(Comment(
      id: 4,
      content: "I’d trade my bike for this beauty any day.",
      likes: 7,
      carId: 2,
      userName: "Paul R.",
    ));
    _comments.add(Comment(
      id: 5,
      content: "Does it come with a spaceship mode?",
      likes: 15,
      carId: 2,
      userName: "Elon M.",
    ));
    _comments.add(Comment(
      id: 6,
      content: "A car so fast, it breaks my WiFi connection!",
      likes: 3,
      carId: 2,
      userName: "Sarah T.",
    ));
    _comments.add(Comment(
      id: 7,
      content: "Where's the cup holder? Deal breaker for me.",
      likes: 4,
      carId: 4,
      userName: "Lisa P.",
    ));
    _comments.add(Comment(
      id: 8,
      content: "Perfect for driving... straight to the nearest gas station.",
      likes: 9,
      carId: 4,
      userName: "Mike F.",
    ));
    _comments.add(Comment(
      id: 9,
      content: "Paint it red, and it's mine!",
      likes: 8,
      carId: 4,
      userName: "Tony S.",
    ));
    _comments.add(Comment(
      id: 10,
      content: "This car looks like it belongs in a superhero movie!",
      likes: 6,
      carId: 2,
      userName: "Peter P.",
    ));
    _comments.add(Comment(
      id: 11,
      content: "Can it survive my parking skills, though?",
      likes: 12,
      carId: 1,
      userName: "Anna L.",
    ));
  }

  // Método para agregar un nuevo comentario
  void addComment(Comment comment) {
    _comments.add(comment);
  }

  // Método para aumentar los likes de un comentario por su ID
  void increaseLikes(int commentId) {
    for (var i = 0; i < _comments.length; i++) {
      if (_comments[i].id == commentId) {
        _comments[i] = Comment(
          id: _comments[i].id,
          content: _comments[i].content,
          likes: _comments[i].likes + 1,
          carId: _comments[i].carId,
          userName: _comments[i].userName,
        );
        break;
      }
    }
  }

  // Método para disminuir los likes de un comentario por su ID
  void decreaseLikes(int commentId) {
    for (var i = 0; i < _comments.length; i++) {
      if (_comments[i].id == commentId) {
        _comments[i] = Comment(
          id: _comments[i].id,
          content: _comments[i].content,
          likes: _comments[i].likes > 0 ? _comments[i].likes - 1 : 0,
          carId: _comments[i].carId,
          userName: _comments[i].userName,
        );
        break;
      }
    }
  }

  // Método para obtener todos los comentarios
  List<Comment> getComments() {
    return _comments;
  }


}