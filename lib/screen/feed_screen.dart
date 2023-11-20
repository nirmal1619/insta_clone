import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/providers/user_provider.dart';
import 'package:riverpod/screen/chat_list_screen.dart';
import 'package:riverpod/widget/post_card.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Widget build(BuildContext context) {


 final user=Provider.of<UserProvider>(context).getUser;

    return Scaffold(


      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 40.0, // Height when fully expanded
            floating: true, // Whether the app bar should become visible as soon as the user scrolls up
            pinned: false,
            backgroundColor: Colors.black,
            bottom: PreferredSize(
      preferredSize: const Size.fromHeight(100),

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(right: 19),
              child:Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            // color: Colors.red, // Set the color of the border
                            width: 4.0, // Set the width of the border
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              user.photoUrl
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 23,
                              width: 23,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.shade400,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              right: -13,
                              top: -11,

                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text("Your story")
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.8,)
            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: Column(
            //     children: [

            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.red, // Set the color of the border
            //             width: 4.0, // Set the width of the border
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: CircleAvatar(
            //           radius: 40,
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //       Text("your story")
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: Column(
            //     children: [

            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.red, // Set the color of the border
            //             width: 4.0, // Set the width of the border
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: CircleAvatar(
            //           radius: 40,
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //       Text("your story")
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: Column(
            //     children: [

            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.red, // Set the color of the border
            //             width: 4.0, // Set the width of the border
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: CircleAvatar(
            //           radius: 40,
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //       Text("your story")
            //     ],
            //   ),
            // ), Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: Column(
            //     children: [

            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.red, // Set the color of the border
            //             width: 4.0, // Set the width of the border
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: CircleAvatar(
            //           radius: 40,
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //       Text("your story")
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: Column(
            //     children: [

            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.red, // Set the color of the border
            //             width: 4.0, // Set the width of the border
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: CircleAvatar(
            //           radius: 40,
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //       Text("your story")
            //     ],
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: CircleAvatar(
            //     radius: 40,
            //     backgroundColor: Colors.white,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: CircleAvatar(
            //     radius: 40,
            //     backgroundColor: Colors.white,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 19),
            //   child: CircleAvatar(
            //     radius: 40,
            //     backgroundColor: Colors.white,
            //   ),
            // ),
            // CircleAvatar(
            //   radius: 40,
            //   backgroundColor: Colors.white,
            // ),
          ],
        ),
      ),

    ),
             actions: <Widget>[
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.paperPlane,
              color: Colors.white, // Set the icon color to white
              size: 24.0,
            ),
            onPressed: () {
              // Handle the chat icon tap action here
              Navigator.push(context,MaterialPageRoute(builder: (_)=>const ChatList()));

            },
          ),
        ],
              title: const Text(
        "Instagram",
    style: TextStyle(
    color: Colors.white, // Set the text color to white
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    ),
    ),
              // Whether the app bar should be pinned at the top
                leading:  const Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white, // Set the icon color to white
                  size: 28.0,
              ),



              flexibleSpace: const FlexibleSpaceBar(
                // titlePadding: EdgeInsets.only(top: 200),
                // expandedTitleScale: 200,
              stretchModes: [StretchMode.zoomBackground],
              ),

          ),
          SliverToBoxAdapter(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("posts").snapshots(),
                builder: (
                    context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasData) {
                    return Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                            (index) => PostCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                      ),
                    );
                  }

                  return Text(snapshot.error.toString());
                },
              ),
            ),
          ),


        ],
      ),

    );
  }
}