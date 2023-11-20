import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  String photo3="https://th.bing.com/th/id/OIP.F4j0D_131-VMhxKcg2IZagHaHZ?w=536&h=535&rs=1&pid=ImgDetMain";
  String photo2="https://th.bing.com/th/id/OIP.KAQ4PQLZB-eJat5W-rx8JwHaJf?rs=1&pid=ImgDetMain";
   String photo1="https://th.bing.com/th/id/OIP.PueDBXJeYUxQHWqaPEc1AQHaLH?rs=1&pid=ImgDetMain";
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.back)),
        title: Text("Notifications"),
        
      ),
      body: Column(
        children: [
       Card(
        color: Colors.black,
         margin: EdgeInsets.symmetric(vertical: 0),
        child: ListTile(
          
         leading: CircleAvatar(
          backgroundImage: NetworkImage(
            photo1),
          radius: 35,
          backgroundColor: Colors.white,
         ),
         title: Text("Follow requests",style: TextStyle(fontWeight: FontWeight.bold),),
         subtitle: Text("Approve or ignore the request"),
        ),
          

       ),
       Padding(
         padding: const EdgeInsets.all(12.0),
         child: Text("Notifications",style: TextStyle(fontWeight: FontWeight.bold),),
       ),
       Card(
        color: Colors.black,
         margin: EdgeInsets.symmetric(vertical: 0),
        child: ListTile(
          trailing: SizedBox(height: 70,width: 50,
          child: Card(
            child: Image(image: NetworkImage(photo3)),
            color: Colors.white,
          ),
          ),
         leading: Stack(
           children: [
             CircleAvatar(
              backgroundImage: NetworkImage(
                photo2
              ),
              radius: 35,
              backgroundColor: Colors.white,
             ),
            //  Positioned(
            //   child: Container(
            //    decoration: BoxDecoration(
            //     color: Colors.red
            //    ),

            //   ),
            //   )
           ],
         ),
         title: RichText(text: TextSpan(
          children: [
        TextSpan(
          text: 'Mr.David', // Your username here
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // TextStyle for bold username
        ),
        TextSpan(
          text: ' liked your photo',
          style: TextStyle(color: Colors.white), // TextStyle for the rest of the text
        ),
      ],
         )),
        
        ),
          
       )
      ]
      ),
    );

      // body: FutureBuilder(
      //   future: FirebaseFirestore.instance
      //   .collection("notifications")
      //   .doc(FirebaseAuth.instance.currentUser!.uid)
      //   .collection("postId")
      //   .get(), 
      //   builder:(context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
      //     if(snapshot)
      //    int docsLength= snapshot.data!.size;
      //     return ListView.builder(
            
      //       itemBuilder: ()
      //       );
      //   }
      //     // (
      //     // context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
      //     //  for(QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.data!.docs){
      //     //  List<dynamic>? likedByData = doc['likedBy'];
      //     //  }
      //   return 
      //     }
        
      
      
      
   
  }
}