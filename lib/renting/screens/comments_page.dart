import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/comment.dart';
import 'package:app_tentify_frfr/shared/services/commentService.dart';

class CommentsPage extends StatefulWidget {
  final int carId;
  final CommentService commentService;

  CommentsPage({required this.carId, required this.commentService});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final Set<int> _likedComments = {};
  final Set<int> _dislikedComments = {};

  @override
  void initState() {
    super.initState();

  }

  void _likeComment(int commentId) {
    if (!_likedComments.contains(commentId) && !_dislikedComments.contains(commentId)) {
      setState(() {
        widget.commentService.increaseLikes(commentId);
        _likedComments.add(commentId);
      });
    }
  }

  void _dislikeComment(int commentId) {
    if (!_likedComments.contains(commentId) && !_dislikedComments.contains(commentId)) {
      setState(() {
        widget.commentService.decreaseLikes(commentId);
        _dislikedComments.add(commentId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = widget.commentService.getComments().where((comment) => comment.carId == widget.carId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: ListView.builder(
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
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => _likeComment(comment.id),
                ),
                Text('${comment.likes}'),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: () => _dislikeComment(comment.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}