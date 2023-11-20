import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:riverpod/screen/profile_screen.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController=TextEditingController();
  bool isShowUser=false;
 
  List<Widget> grid=[];

 double getRandom(){
  final random=Random();
   return random.nextDouble();
 }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      
        toolbarHeight: 70,
        backgroundColor: Colors.black38,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 45, 43, 43), // Grey background color
              borderRadius: BorderRadius.circular(18), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search........',
                  border: InputBorder.none, // Remove TextField border
                  icon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  setState(() {
                    isShowUser = true;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: isShowUser? FutureBuilder(
      future: FirebaseFirestore.instance
      .collection('userinfo')
      .where('username',isGreaterThanOrEqualTo: _searchController.text).get(),
      builder: (context, snapshot){

        if(snapshot.hasData){
         return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context,index){
            bool _isNull=false;
            if((snapshot.data! as dynamic).docs[index]['photoUrl']!=null || (snapshot.data! as dynamic).docs[index]['username']!=null ){
              _isNull=true;
            }


            return InkWell(

              child: ListTile(
                leading: _isNull?CircleAvatar(
                  backgroundImage:  NetworkImage(
                    (snapshot.data! as dynamic).docs[index]['photoUrl'],
                  ),
                ): CircleAvatar(
                  child: CircularProgressIndicator(),
                ),
                title: _isNull? Text((snapshot.data! as dynamic).docs[index]['username']):Text("userName"),
              ),
              onTap: ()=>Navigator.of(context)
                  .push(
                  MaterialPageRoute(
                      builder: (_)=>ProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['uid']))),
            );


          }

         );
         
        }

        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
      ): FutureBuilder(future: FirebaseFirestore.instance.collection('posts').get(),
       builder: (context,snapshot){
          if(!snapshot.hasData){
            Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.data==null){
            Center(child: CircularProgressIndicator(),);
          }else{
            return MasonryGridView.builder(

              itemCount:  (snapshot.data! as dynamic).docs.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)
              ,itemBuilder:(context,Index)=>Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                // decoration: BoxDecoration(backgroundBlendMode: BlendMode.colorBurn),
                // height: MediaQuery.of(context).size.height* double.infinity/Index,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    (snapshot.data! as dynamic).docs[Index]['postUrl'],
                  ),
                ),
              ),
            ),

            );
          }


  return Center(child: CircularProgressIndicator(),);

       }
       
       )
    );
  }
}

//  GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            
//             crossAxisCount: 3,
//             childAspectRatio: 1.3,
//             ),
//            itemBuilder: (context,Index)=>Image.network(
//             (snapshot.data! as dynamic).docs[Index]['postUrl'],
//            )
//            );
