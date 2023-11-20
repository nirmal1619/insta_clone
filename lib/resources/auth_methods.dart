import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/model/user.dart' as model;
import 'package:riverpod/resources/storage_methods.dart';
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 //  
  Future<model.User> getUserDetails()async{
     User currentUser= _auth.currentUser!;

  DocumentSnapshot snap= await FirebaseFirestore.instance
  .collection('userinfo').
  doc(currentUser.uid)//it calso could be _auth.currntuser!.uid;
  .get();

  return model.User.fromsnap(snap);
  }


  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occurred";
    try {
      if (
          email.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty 
          ||
          // ignore: unnecessary_null_comparison
          file != null
          ){
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      
       
       
        String photoUrl=await storageMethods()
              .uploadImageStorage("profile", file, false);
        
     // Create a model User object
        model.User modelUser = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: userName,
          bio: bio,
          followers: [], // Initialize with an empty list or provide actual followers data
          following: [], // Initialize with an empty list or provide actual following data
        );

  // add data to firebase storage

     
        await _firestore.collection("userinfo")
        .doc(cred.user!.uid).set(modelUser.toJson());

        res="succesful";

      }
    }
     catch (err) {
      res = err.toString();

    }
    print(res);
    return res;
  }

  // logging user 

    Future<String> loginUser({
      required String email,
      required String password,
    })async
    {
     String res="Some error ";
    
    try {
      if(email.isNotEmpty || password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(
          email: email, password: password
          );
          res="success";
      }
      else{
        res="user need to fill all fields";

      }
    }
    on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){

      }
      if(e.code=="user-not-found"){

      }

    }
    catch(err){
           res=err.toString();
    }
     print(res);
       return res;
    }



   Future <void> signout ()async{
  await _auth.signOut();
   }


}
