import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/resources/firestore_method.dart';
import 'package:riverpod/screen/profile_screen.dart';

class ChatScreen extends StatefulWidget {
  final reciverUser;

  const ChatScreen({Key? key, required this.reciverUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  var currentUser;
  bool isSent=false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    createDataBase();
    
  }

  createDataBase() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var snap = await FirebaseFirestore.instance.collection('userinfo').doc(uid).get();
    currentUser = snap.data()!;

    await FireStoreMethod().messageF(
      widget.reciverUser['uid'],
      currentUser['uid'],
      currentUser['username'],
      currentUser['photoUrl'],
    );
  }

  final firebaseInstance = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }
 void scrollToBottom(){
  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.black,
        actions: [

            IconButton(iconSize:25, onPressed: (){}, icon: Icon(CupertinoIcons.phone)),
            IconButton(iconSize:30,onPressed: (){}, icon: Icon(CupertinoIcons.video_camera),),

        ],
        leading: Padding(
          padding: EdgeInsets.all(0),
          child: CircleAvatar(
            radius: 200,
            backgroundImage: NetworkImage(widget.reciverUser["photoUrl"]),
          ),
        ),
        title: Text(widget.reciverUser['username']),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(150), 
        //   child: userBasicInfo()
        //   ),
      ),
      body: Column(
        children: [
        
          Container(
            
            child: StreamBuilder(
              stream: firebaseInstance.collection(widget.reciverUser['uid']).doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final mq=MediaQuery.of(context).size;
                  List<dynamic> messages = snapshot.data!.get('messages');
                  List<dynamic> timeStamp=snapshot.data!.get('dateTime');
                  bool _isSeen=snapshot.data!.get('isSeen');
                  int length=messages.length;
                  
                  return Expanded(
                    child: ListView.builder(
                      // reverse:true ,
                    controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        String message = messages[index];
                        List<String> parts = message.split("**");
                         String mainMessage=parts[0];


                        //  print("time => ${time} date=>${date}");
                      
                      bool isSentByMe=(parts[1] == "sent");
                    
                        return  Container(

                          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Column(
                            children: [
                              
                               index==0?userBasicInfo():
                              Row(
                                mainAxisAlignment:
                                isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                                children: <Widget>[
                                  
                                  isSentByMe? Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: mq.width*0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                              color: isSentByMe ? Colors.blue : Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Text(
                                              mainMessage,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                         
                                          
                                          (length-1==index) ?
                                          _isSeen ? Text("seen"): Text("sent"): 
                                          
                                          
                                          Text("",style: TextStyle(fontSize: 1),)
                                        ],
                                      ),
                                    ),
                                  ):Flexible(
                                    child: Row(
                                      children: [
          
                                   Padding(
                                          padding:  EdgeInsets.only(right: mq.width*0.3),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(0),
                                                    topLeft: Radius.circular(20),
                                                    topRight: Radius.circular(15),
                                                    bottomRight: Radius.circular(15),
                                                  ),
                                                ),
                                                child: Text(
                                                  mainMessage,
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        );
                      },
                    )
                    );
          
                }
          
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
          
                if (!snapshot.hasData) {
                  return Center(
                    child: sayHii(),
                  );
                }
          
                return const Text("no data");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFieldLogic(),
          ),
        ],
      ),
    );
  }

  Widget sayHii(){
    return Container(
    child: Text("say hi to ${widget.reciverUser['username']}"),
    );
  }

Widget userBasicInfo(){
 List followers=widget.reciverUser['followers'];
List following=widget.reciverUser['following'];

  return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      widget.reciverUser["photoUrl"],

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.reciverUser['bio'],style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ) ,),
                  ),
                  Text("Instagram. ${widget.reciverUser['username']},",style: TextStyle(color: Colors.white),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("followers ${followers.length}"
                  ,style: TextStyle(color: Colors.white)),
                  SizedBox(width: 12,),
                  Text("following ${following.length}",
                  style: TextStyle(color: Colors.white))],),
                   Text("You Both Follow Each Other On Instagram",
                  style: TextStyle(color: Colors.white)),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) =>Colors.grey.shade800),
                    ),
                    onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProfileScreen(uid:  widget.reciverUser['uid']))),
                     child: Text("view Profile")),
                    
                ],
                
              )
            ],
          );
}

  Widget TextFieldLogic() {
    return Container(
      height: 50,
      // color: Colors.black12,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
    Container(
  width: 40,
  height: 40,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.blue, // Adjust the color as needed
  ),
  child: IconButton(
    icon: const Icon(Icons.camera_alt, color: Colors.white),
    onPressed: () {
      // Handle camera icon press
    },
  ),
),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.white),
            onPressed: () {
              // Handle mic icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white),
            onPressed: () {
              // Handle send icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () async {
           isSent = await FireStoreMethod().SendMessageF(
                widget.reciverUser['uid'],
                currentUser['uid'],
                _messageController.text,

              );
              scrollToBottom();
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
