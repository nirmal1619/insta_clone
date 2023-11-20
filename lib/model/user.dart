

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List<dynamic> followers; // Use dynamic or specify a data type
  final List<dynamic> following; // Use dynamic or specify a data type

  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });
 
  
  Map<String ,dynamic>toJson()=>{
   
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'username': username,
      'bio': bio,
      'followers': followers,
      'following': following,

  };
  
  static User fromsnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String, dynamic>;

    return User(
    email: snap['email'],
    uid: snap['uid'],
    photoUrl: snap['photoUrl'],
    username: snap['username'],
    bio: snap['bio'],
    followers: snap['followers'],
    following: snap['following'],
    );
  }



}
