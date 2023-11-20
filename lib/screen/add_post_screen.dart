import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/model/user.dart' as ProviderUser;
import 'package:riverpod/providers/user_provider.dart';
import 'package:riverpod/resources/firestore_method.dart';
import 'package:riverpod/utilis/colors.dart';
import 'package:riverpod/utilis/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}


class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool _isLoading=false;
  final TextEditingController _descriptionController = TextEditingController();



  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading=true;
    });
    try {
      String res = await FireStoreMethod().uploadPost(
          _file!, _descriptionController.text, uid, username, profImage);

      if (res == "success") {
        
        setState(() {
         _isLoading=false;
        });
       
        clearImage();
         showSnackbar(res, context);
      
        
       
      } else {
        showSnackbar(res, context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }
  void clearImage(){
    setState(() {
      _file=null;
    });
  }

  _selectImage(BuildContext) async {
    return showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text("Take a Post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);

                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose From gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);

                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
@override
  void initState() {
    // TODO: implement initState
  
   getImage();
  
    
  }
  Future<void>  getImage()async{
     Uint8List file = await pickImage(ImageSource.gallery);

                setState(() {
                  _file = file;
                });
  }
Widget buildCaptionInput() {
  final Size mq = MediaQuery.of(context).size;
  return SizedBox(
    width: mq.width * 0.70,
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        
        child: TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: "Write a caption",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            // border: InputBorder.none,
          ),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}


  Widget build(BuildContext context) {
    final ProviderUser.User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _selectImage(context);
                  },
                  icon: const Icon(CupertinoIcons.cloud_upload),
                ),
              ],
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Post To"),
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(
                        user.uid, user.username, user.photoUrl);
                        
                          FocusScope.of(context).unfocus();
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _isLoading ? const LinearProgressIndicator()
                  :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      buildCaptionInput(),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
