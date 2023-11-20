class CommentModel {
  final String profilepic;
  final String name;
  final String uid;
  final String text;
  final String commentId;
  final String datePublished;

  CommentModel({
    required this.profilepic,
    required this.name,
    required this.uid,
    required this.text,
    required this.commentId,
    required this.datePublished,
  });

Map<String,dynamic>toJson(){
  return{
  'profilepic': profilepic,
    'name': name,
    'uid': uid,
    'text': text,
    'commentId': commentId,
    'datePublished': datePublished,
  };
}

 fromJson(){
  
 }

}
