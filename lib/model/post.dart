

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      description: json['description'] ,
      uid: json['uid'] ,
      username: json['username'] ,
      postId: json['postId'] ,
      datePublished: json['datePublished'] ,
      postUrl: (json['postUrl'] ),
      profileImage: json['profileImage'] ,
      likes: json['likes'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'uid': uid,
      'username': username,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profileImage': profileImage,
      'likes': likes,
    };
  }
}
