import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/model/comment_model.dart';
import 'package:riverpod/model/notification_model.dart';
import 'package:riverpod/model/post.dart';
import 'package:riverpod/model/send_message_model.dart';
import 'package:riverpod/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';



class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var dof1;
var dof2;

  Future<String> uploadPost(
    Uint8List postimage,
    String description,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = "";

    try {
      String postUrl =
          await storageMethods().uploadImageStorage("posts", postimage, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: postUrl,
        profileImage: profileImage,
        likes: [],
      );

      await _firestore.collection("posts").doc(postId).set(post.toJson());
      await notificationsDataBase(uid, postId);
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    print(res);
    return res;
  }

  Future likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {}
  }

  Future<void> postComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilepic,
  ) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        DateTime now = DateTime.now().toUtc();
        String formattedDate = DateFormat('d/M/yy').format(now);

        final comments = CommentModel(
          profilepic: profilepic,
          name: name,
          uid: uid,
          text: text,
          commentId: commentId,
          datePublished: formattedDate,
        );

        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comments.toJson());
      } else {
        // print("text is empty");
      }
    } catch (e) {
      // print("error is in comment ${e}");
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      // print(e);
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('userinfo').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('userinfo').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('userinfo').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('userinfo').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('userinfo').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> messageF(
    String reciverUid,
    String senderUid,
    String username,
    String profilePhoto,
  ) async {
    try {

      var snap=await FirebaseFirestore.instance.collection("userinfo").doc(reciverUid).get();
      String username2="";
      String photoUrl="https://th.bing.com/th/id/R.80fd6d54a2547a1c7b917e37aa6ad2b3?rik=m8nw%2fm8ofm8CIA&riu=http%3a%2f%2fwww.drodd.com%2fimages14%2fwhite1.jpg&ehk=LPtvl6wBoDpGaTIkUov3nMMijbg%2b9yJMH02rHwy4w%2fU%3d&risl=&pid=ImgRaw&r=0";
      if(snap.exists){
        username2=snap.data()?['username'];
         photoUrl=snap.data()?['photoUrl'];
      }
      else{

      }

       DocumentSnapshot snap1= await _firestore
          .collection(reciverUid)
          .doc(senderUid).get();
          
          if(snap1.exists){
            print("exist");
          }else{

      SendMessage message1 = SendMessage(
        receiverUid: reciverUid,
       senderUid: senderUid,
        profilePhoto:profilePhoto,
        messages:[] ,
         dateTime: [], 
       isSeen: false,
         senderUsername: username,
        
         );

      await _firestore
          .collection(reciverUid)
          .doc(senderUid)
          .set(message1.toJson());

        //secod
      DocumentSnapshot snap2= await _firestore
          .collection(senderUid)
          .doc(reciverUid).get();

      if(snap2.exists){
        print("exist");
      }else{
        SendMessage message2 = SendMessage(
            receiverUid: senderUid,
            senderUid: reciverUid,
            profilePhoto: photoUrl,
           messages: [],
            dateTime: [],
            isSeen: false,
            senderUsername:username2,
           
        );

        await _firestore
            .collection(senderUid)
            .doc(reciverUid)
            .set(message2.toJson());

      }


          }
    } catch (e) {
      // print(e.toString());
    }
    
  }

  Future<bool> SendMessageF(
    
      String reciverUid, String senderUid, String message) async {
    try {
   DocumentReference currntUserDocRef=await _firestore.collection(reciverUid).doc(senderUid);
      dof1=currntUserDocRef;
      await currntUserDocRef.update({
         
        'messages': FieldValue.arrayUnion([message+"**sent" ]),
        'dateTime': FieldValue.arrayUnion([DateTime.now()]),
        'isSeen': false,

      });

   DocumentReference otherUserDocRef= await _firestore.collection(senderUid).doc(reciverUid);
   dof2=otherUserDocRef;
      otherUserDocRef.update({
        
        'messages': FieldValue.arrayUnion([message+"**rece"]),
         'dateTime': FieldValue.arrayUnion([DateTime.now()]),
        'isSeen': false,
      });
      return true;
      
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future <void> isSeen( String reciverUid, String senderUid)async{
   try{

    DocumentReference otherUserDocRef= await _firestore.collection(senderUid).doc(reciverUid);
    //  await currntUserDocRef.update({
    //    'isSeen' :true,
    //  });
     await otherUserDocRef.update({
       'isSeen' : true,
     });
   }
       catch(e){
     print(e.toString());
    }
  }

   Future<void> notificationsDataBase(String postOwenerUid,String postUid)async{
  try{
    
 DocumentReference snapRef=  await _firestore.collection("notifications")
 .doc(postOwenerUid).collection(postUid).doc(postUid);

      NotificationModel notificationModel=NotificationModel(
      likedBy:[],
       commentBy:[], 
       postId: postUid,
        postOwnerUid: postOwenerUid,
        );
      await snapRef.set(notificationModel.toJson());
     
  }
  catch(e){
    print("${e}");
  }
   }

   Future<void> setPostOperationData(String postOwenerUid,String OperationFerformedBy
   ,String postUid,bool comment,bool liked)async{
    try{
      DocumentReference snapRef=  _firestore.collection("notifications")
 .doc(postOwenerUid).collection("postId").doc(postUid);
    DocumentSnapshot snapshot=await snapRef.get();
    if(snapshot.exists){
      print("set operation snapshot >>>>>>>>>>>${snapshot}");
      if(liked){
          snapRef.update({
        "likedBy": FieldValue.arrayUnion([OperationFerformedBy])
      });
      }
      if(comment){
  snapRef.update({
        "commentBy": FieldValue.arrayUnion([OperationFerformedBy])
      });
      }
    }else{
      print("snap doesnt exists");
    }
 
     
    }
    catch(e){

    }
   }

   

  // Future<bool> deletetMessageF(
  //     String sender, String receiver, String message) async {
  //   bool v = false;

  //   try {
  //     await _firestore.collection('messages').doc("R").collection("S").doc().update({
  //       'messages': FieldValue.arrayRemove([message]),
  //     }).then((value) => v = true);
  //   } catch (e) {
  //     print(e.toString());
  //   }

  //   return v;
  // }




}
