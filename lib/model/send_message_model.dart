

class SendMessage {
  final String receiverUid;
  final String senderUid;
  final String profilePhoto;
  final List<DateTime> dateTime;
  final List<String> messages;
  final bool isSeen;
  final String senderUsername;



  SendMessage(  {
    required this.receiverUid,
    required this.senderUid,
    required this.profilePhoto,
    required this.dateTime,
    required this.messages,
  required this.isSeen,
  required this.senderUsername,

  });
 
 Map<String,dynamic>toJson(){
   return {
    'receiverUid': receiverUid,
        'senderUid': senderUid,
        'profilePhoto': profilePhoto,
        'dateTime': dateTime.toList(),
        'messages': messages,
         'isSeen':isSeen,
        'senderUsername': senderUsername,
    
        
   };
 }
  
 
}