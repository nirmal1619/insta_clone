import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/providers/user_provider.dart';
import 'package:riverpod/resources/firestore_method.dart';
import 'package:riverpod/screen/comment_screen.dart';
import 'package:riverpod/utilis/colors.dart';
import 'package:riverpod/widget/like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
String formattedDate ="";
   void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
    String firebaseDateString = widget.snap['datePublished'].toString();

// Parse the date string
DateTime dateTime = DateTime.parse(firebaseDateString);

// Format the date
 formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    
    // print("snap odf post crad ${widget.snap}");
  }
  
  void getComments()async{
  try{
    QuerySnapshot quarySnap=await FirebaseFirestore.instance 
  .collection('posts') 
  .doc(widget.snap['postId'])
  .collection('comments')
  .get();
   commentLen=quarySnap.size;
  setState(() {
      commentLen=quarySnap.docs.length;
  });
  }
  catch(e){
  // print(e.toString());
  }

  }

  bool isLikeAnimating=false;
  int commentLen=0;
  Widget build(BuildContext context) {
    final Size mq=MediaQuery.of(context).size;
  
  final user =Provider.of<UserProvider>(context).getUser;


    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      widget.snap['profileImage'],
                      ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      Text(
                        widget.snap['username'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(width: mq.width*0.5,),
                IconButton(onPressed: () {
                  // showDialog(context: context, builder: (_)=>Text(widget.snap['profileImage']));
                  showDialog(context: context, builder: (_)=>Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: [
                            "delete"

                          ].map((e) => InkWell(
                            onTap: ()async{
                             await FireStoreMethod().deletePost(widget.snap['postId']).then((value) => Navigator.of(context).pop());

                            },
                            child: Container(
                            padding: EdgeInsets.symmetric(vertical:12,horizontal: 16 ),
                          child: Text(e),
                          ),


                          ),
                          ).toList(),
                        ),
                  )
                  );

                },
                icon: Icon(Icons.more_vert)
                )
              ],
            ),
            //image section
             

          ),
          GestureDetector(
            onDoubleTap: ()async{
              await FireStoreMethod().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes']
              );
              setState(() {
              
                isLikeAnimating=true;
              });
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                   SizedBox(
                  height: mq.height*0.45,
                  width: mq.width,
                  child: Image.network(widget.snap['postUrl'],fit: BoxFit.cover,) // NetworkImage(snap['postUrls'])
                 ),
                 AnimatedOpacity(
                  
                  child: LikeAnimation(child: Icon(Icons.favorite ,size: 100,

                 color: Colors.white,), 
                 isAnimating: isLikeAnimating,
                  duration: Duration(milliseconds: 400), 
               
                  onEnd: () {
                    setState(() {
                      isLikeAnimating=false;
                    });
                  },
                  ),
                  
                  opacity: isLikeAnimating? 1:0,
                  duration: const Duration(milliseconds: 200))
                , 
              ],
                  
            ),
          ),
             //like coioment section

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             
             
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
               smallLike: true,
                
                child: IconButton(onPressed: ()async{
                  
                     await FireStoreMethod().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes']
              );
             await FireStoreMethod().setPostOperationData( widget.snap['uid'],user.uid,widget.snap['postId'],false, true);
                },
              
                 icon:   widget.snap['likes'].contains(user.uid)?Icon(Icons.favorite
                 ,
                 color: Colors.red,
                 ):
              Icon(Icons.favorite_border_outlined
                 ,
                 color: Colors.white,
                 ),
                 ),
              ),
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:
                   (_)=>CommentScreen(
                    snap: widget.snap)
                   )
                   );
                },
               icon: Icon(CupertinoIcons.chat_bubble,
               
               color: Colors.white,
               ),

               ),
                IconButton(onPressed: (){},
               icon: Icon(CupertinoIcons.paperplane
               ,
               color: Colors.white,
               ),

               ),
               SizedBox(width: mq.width*0.4,),
               IconButton(
                 onPressed: (){},
               icon: Icon(Icons.bookmark_border_outlined
               ,
               color: Colors.white,
               ),

               )
             ],),
             //description and number of comments 
             Container(
              padding:  EdgeInsets.only(top: 0),
              child: Column(
                children: [
                 
                Row(
                 children: [
                   SizedBox(width: 15,),
                
                  Text("${widget.snap['likes'].length} likes"),
                 ],
                ),
                Row(
                  children: [
                     SizedBox(width: 15,),
                    Text(widget.snap['username'],style: TextStyle(fontWeight: FontWeight.bold),),

                    SizedBox(width: 5,),
                    Text(widget.snap['description']),
                  ],
                ), 
                 InkWell(
                  onTap: (){},
                  child: Row(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15,height: 5,),

                      Text("View all ${commentLen} comments",style: TextStyle(color: Colors.grey.shade400),),
                    ],
                  ),
                 )  ,
                 SizedBox(height: 5,),
                    Row(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15,),

                      Text(formattedDate,style: TextStyle(color: Colors.grey.shade400),),
                    ],
                  ), 
                ],
              ),
             )
        ],
      ),
    );
  }
}
