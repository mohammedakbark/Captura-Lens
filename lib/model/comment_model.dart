class CommentModel {
  String commentedUid;
  String comment;
  String commentePostId;

  CommentModel(
      {required this.comment,
      required this.commentePostId,
      required this.commentedUid});
}
