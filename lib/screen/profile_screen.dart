import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/resources/auth_methods.dart';
import 'package:riverpod/resources/firestore_method.dart';
import 'package:riverpod/screen/chat_screen.dart';
import 'package:riverpod/utilis/colors.dart';
import 'package:riverpod/widget/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});
  final String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var UserData;
  var PostData;
  int postLength=0;
  int followers=0;
  int following=0;
  bool isFollwing=false;
  bool _isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

getData()async{
  try{
   setState(() {
     _isLoading=true;

   });
    var UserSnap= await FirebaseFirestore.instance
    .collection('userinfo')
    .doc(widget.uid)
    .get();

    var postSnap=await FirebaseFirestore.instance.collection('posts')
    .where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    
     postLength=postSnap.docs.length;
     followers=UserSnap['followers'].length;
     following=UserSnap['following'].length;

     isFollwing=UserSnap.data()!['followers']
     .contains(FirebaseAuth.instance.currentUser!.uid);
  setState(() {
   UserData=UserSnap.data()!;
   
  });
  }
  catch(e){
  }
  setState(() {
    _isLoading=false;
  });
}

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  _isLoading? const Center(child: CircularProgressIndicator(),): Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(100),
          //    child: Toolbar
          //    ),
          backgroundColor: mobileBackgroundColor,
          title: Text(UserData['username']),
          actions: [
             IconButton(onPressed: ()async{
              await AuthMethods().signout();
             }, icon: const Icon(Icons.exit_to_app))
          ],
          
        ),
        body: 
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
               
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                       backgroundImage: NetworkImage(UserData['photoUrl']),
            
                      ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildstateColumn(postLength, 'posts'),
                           buildstateColumn(followers, 'followers'),
                            buildstateColumn(following, 'following'),
                        ],
                      ),
                    ),
                  
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                    children: [
                        Text(UserData['bio']),
                    ],
                    
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FirebaseAuth.instance.currentUser!.uid==widget.uid?
                      FollowButton(
                      widget: size.width*0.47,
                      backgroundColor: mobileBackgroundColor,
                       bordercolor: Colors.grey,
                  
                        text: 'edit profile', 
                        textcolor: Colors.white,
                        function: (){},
                        ):isFollwing? FollowButton(
                      widget: size.width*0.47,
                      backgroundColor: mobileBackgroundColor,
                       bordercolor: Colors.grey,
                  
                        text: 'unfollow', 
                        textcolor: Colors.white,
                        function: ()async{
                          await FireStoreMethod().
                          followUser(
                            FirebaseAuth
                          .instance.currentUser!.uid,UserData['uid']);
                         setState(() {
                            isFollwing=false;
                            followers--;
                          });
                        },
                        ):FollowButton(
                      widget: size.width*0.47,
                      backgroundColor: mobileBackgroundColor,
                       bordercolor: Colors.grey,
                  
                        text: 'follow', 
                        textcolor: Colors.white,
                        function: ()async{
                          await FireStoreMethod().
                          followUser(FirebaseAuth
                          .instance.currentUser!
                          .uid,UserData['uid']);
                          setState(() {
                            isFollwing=true;
                            followers++;
                          });
                        },
                        
                        )
        
                        ,
                        const SizedBox(width: 5,),
        
        
                       FirebaseAuth.instance.currentUser!.uid==widget.uid?
                      FollowButton(
                      widget: size.width*0.47,
                      backgroundColor: mobileBackgroundColor,
                       bordercolor: Colors.grey,
                  
                        text: 'share profile', 
                        textcolor: Colors.white,
                        function: (){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen(reciverUser: UserData,)));
                        },
                        ):isFollwing? FollowButton(
                      widget: size.width*0.47,
                      backgroundColor: mobileBackgroundColor,
                       bordercolor: Colors.grey,
                  
                        text: 'message', 
                        textcolor: Colors.white,
                        function: (){
                        // print("userdara ======= ${UserData}");
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen(reciverUser: UserData,)));
                        },
                        ):FollowButton(
                      widget: size.width*0.47,
                      backgroundColor: mobileBackgroundColor,
                       bordercolor: Colors.grey,
                  
                        text: 'message', 
                        textcolor: Colors.white,
                        function: (){
                          // print("userdara ======= ${UserData}");
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen(reciverUser: UserData,)));
                        },
                        )
                  ],
          //chat list
          // {senderUid: cGLeqQlno0T1WT9HWvgHhCV42RE3, dateTime: 2023-11-12T08:10:49.981816, profilePhoto: https://firebasestorage.googleapis.com/v0/b/instagram-clone-8c950.appspot.com/o/profile%2FNpJYDeMFFKhgR0cWhoFAED8K9Kw1?alt=media&token=0f8b7269-7cc3-4353-a3d6-47a127fe0092, lastOperation: S, receiverUid: NpJYDeMFFKhgR0cWhoFAED8K9Kw1, sentMessages: [], receiverMessages: [kesa h bhai.#time2023-11-12 08:13:03.400766, vvh.#time2023-11-12 08:39:51.063756, c. d den.#time2023-11-12 08:46:21.833020, uvviv.#time2023-11-12 08:50:48.472338], senderUsername: second}
        
        
          //messsage
          // I/flutter (25264): userdara ======= {photoUrl: https://firebasestorage.googleapis.com/v0/b/instagram-clone-8c950.appspot.com/o/profile%2FcGLeqQlno0T1WT9HWvgHhCV42RE3?alt=media&token=14a75b74-7e65-482f-bf25-ac4b54fc7a81,
                    // uid: cGLeqQlno0T1WT9HWvgHhCV42RE3, followers: [QHouow5NdOTzG7KzngyUCGjbf923, NpJYDeMFFKhgR0cWhoFAED8K9Kw1], following: [NpJYDeMFFKhgR0cWhoFAED8K9Kw1], bio: babbaaana, email: nirmalsuman056@gmail.com, username: baba161902}
          // I/flutter (25264): sentmessages [kesa h bhai.#time2023-11-12 08:13:02.877683, vvh.#time2023-11-12 08:39:50.539557, c. d den.#time2023-11-12 08:46:21.233702, uvviv.#time2023-11-12 08:50:47.985541]
          // I
          //                             )  ,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                        Icon(Icons.grid_view_sharp),
                         Icon(Icons.list_alt_outlined),
                          Icon(Icons.person_2_outlined),
                       ],
                      ),
                    ),
                  ),
                 FutureBuilder(future: FirebaseFirestore.instance.collection("posts").where('uid',isEqualTo: widget.uid).get(),
             builder:(context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 1,childAspectRatio: 1) , 
                itemBuilder: (context,index){
                  DocumentSnapshot snap=(snapshot.data! as dynamic).docs[index];
                  return Container(
                    decoration: BoxDecoration(
                      border:Border.all(
                        color: Colors.grey,
                        width: 2
                      )
                    ),
                    margin: const EdgeInsets.all(8),
                    child: Image(
                      image: NetworkImage(
                        (snap.data()! as dynamic)['postUrl'],
                      ),
                    ),
                  );
                },
                );
             } 
             )
                ],
        
              ),
            ),
           
          ],
        )
    );
    
  }

  Column  buildstateColumn(int num,String label){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}