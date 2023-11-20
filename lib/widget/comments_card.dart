import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/providers/user_provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {

  @override

  Widget build(BuildContext context) {
    
      final user =Provider.of<UserProvider>(context).getUser;
    return Container(
       padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8), 
       child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              user.photoUrl,
            ),
            radius: 18,

          ),
          Expanded(
            child: Padding(padding: EdgeInsets.only(left:17 )
            ,child: Column(
          
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${user.username}',
                      style: TextStyle(fontWeight: FontWeight.bold),
          
                    ),
                    
                    TextSpan(
                      text: '  ${widget.snap['text']}'
                      // style: TextStyle(fontWeight: FontWeight.bold)
                    )
                  ]
                ),
                ),
                Padding(padding: EdgeInsets.only(top:4 ),
                child: Text(
              widget.snap['datePublished'],
                
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                ),
                ),
                ),
              ],
            ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child:Icon(Icons.favorite,size: 16,),
          )
        ],
       ),
    );
  }
}  