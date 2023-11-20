import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/providers/user_provider.dart';
import 'package:riverpod/resources/firestore_method.dart';
import 'package:riverpod/screen/chat_screen.dart';
import 'package:riverpod/utilis/colors.dart';
import 'package:riverpod/widget/chat_card.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key});

  @override
  State<ChatList> createState() => _ChatListState();
}


class _ChatListState extends State<ChatList> {


  @override
  Widget build(BuildContext context) {
   var user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(user.username),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => InkWell(
              
              child: ChatCard(
                snap: snapshot.data!.docs[index].data(),
              ),
              onTap: () async {
                FireStoreMethod()
                .isSeen(snapshot.data!.docs[index].data()['senderUid'],
                FirebaseAuth.instance.currentUser!.uid); 
                
                print("snap shot for chatcar ${snapshot.data!.docs[index].data()}");
                  // await FireStoreMethod().isSeen();
                  //   print("data() => ${ snapshot.data!.docs[index].data()}");
                  var user= await  FirebaseFirestore.instance
                        .collection('userinfo')
                        .doc(snapshot.data!.docs[index].data()['senderUid'])
                        .get();
                  var userData=user.data();
                // print("userdata ${userData}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                     reciverUser: userData
                      // reciverUser:  snapshot.data!.docs[index].data(),
                    ),
                  ),
                );
              },
            ),
          );
          }
          print(snapshot);
          return Text("no messages");
        },
      ),
    );
  }
}
