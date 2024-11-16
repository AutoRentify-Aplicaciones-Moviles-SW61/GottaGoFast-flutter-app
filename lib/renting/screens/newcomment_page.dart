import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/comment.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';

class NewcommentPage extends StatefulWidget {
  final int carId;
  final CommentService commentService;

  const NewcommentPage({Key? key, required this.carId, required this.commentService}) : super(key: key);

  @override
  _NewcommentPageState createState() => _NewcommentPageState();
}

class _NewcommentPageState extends State<NewcommentPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    final currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      final newComment = Comment(
        id: widget.commentService.getComments().length + 1,
        content: _commentController.text,
        likes: 0,
        carId: widget.carId,
        userName: currentUser.name ?? 'Unknown User',
      );
      setState(() {
        widget.commentService.addComment(newComment);
        _commentController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = widget.commentService.getComments().where((comment) => comment.carId == widget.carId).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    title: Text(comment.userName),
                    subtitle: Text(comment.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up),
                          onPressed: () {
                            setState(() {
                              widget.commentService.increaseLikes(comment.id);
                            });
                          },
                        ),
                        Text('${comment.likes}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}