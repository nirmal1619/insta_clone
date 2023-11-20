import 'package:flutter/material.dart';
import 'package:riverpod/utilis/colors.dart';

class ChatCard extends StatefulWidget {
  final snap;

  const ChatCard({Key? key, required this.snap}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  bool isSent = false;

  @override
  Widget build(BuildContext context) {
    int index = widget.snap['messages']?.length ?? -1;
    // String _isSeen=widget.snap['seen'];
    if (index == -1) {
      return Text("no message");
    }

    String lastMessage = widget.snap['messages'][index -1];
    String profileUrl = widget.snap['profilePhoto'];
    String senderUserName = widget.snap['senderUsername'];
    List<String> parts = lastMessage.split("**");

    print("parts1 ${parts[1]}  ");

    if (parts[1]=="rece") {
      return _buildCard(profileUrl, senderUserName, parts[0], true);
    }
    else
 {//  (parts[1]=="rece")
      return _buildCard(profileUrl, senderUserName, parts[0], false);
    }
  }

  Widget _buildCard(
      String profilePhoto, String title, String subtitle, bool isSent) {
    String message = subtitle;

    return Card(
      color: mobileBackgroundColor,
      margin: EdgeInsets.all(3),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profilePhoto),
          backgroundColor: Colors.white,
          radius: 35,
        ),
        title: Text(title),
        subtitle: isSent
            ? Text(message)
            : Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
