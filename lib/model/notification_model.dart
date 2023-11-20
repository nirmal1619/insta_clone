class NotificationModel {
  final List<String> likedBy;
  final List<String> commentBy;
  final String postId;
  final String postOwnerUid;

  NotificationModel({
    required this.likedBy,
    required this.commentBy,
    required this.postId,
    required this.postOwnerUid,
  });

  Map<String, dynamic> toJson() {
    return {
      'likedBy': likedBy,
      'commentBy': commentBy,
      'postId': postId,
      'postOwnerUid': postOwnerUid,
    };
  }
}
