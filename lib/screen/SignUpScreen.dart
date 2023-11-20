import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/resources/auth_methods.dart';
import 'package:riverpod/responsive/mobile_screen_layout.dart';
import 'package:riverpod/responsive/responsive_layout_screen.dart';
import 'package:riverpod/responsive/web_screen_layout.dart';
import 'package:riverpod/utilis/colors.dart';
import 'package:riverpod/utilis/utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool isLoading=false;


  void _handleSignUp() async {
    setState(() {
      isLoading=true;
    });

String res = await AuthMethods().signUpUser(
  
  file: _image!,
  email: _emailController.text,
  password: _passwordController.text,
  userName: _usernameController.text,
  bio: _bioController.text,
);
    print(res);
    if(res=='succesful'){
       showSnackbar("successful", context);
       
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_){
          return  const Responsive(
        MobileScreenLayout: MobileScreenLayout(),
        WebScreenLayout: WebScreenLayout(),
      
        );
        })
       );
    }
    else{
      setState(() {
        isLoading=false;
      });
      showSnackbar(res, context);
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Stack(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    // Replace the image with your desired network image
                    image: _image != null
                        ? DecorationImage(
                            image: MemoryImage(_image!), // Use MemoryImage for Uint8List
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                          
                            image: NetworkImage('https://example.com/your_image_url.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () {
                      // Handle camera icon click
                      selectImage();
                      // storageMethods().uploadImageStorage("profilehh",_image! , false);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 110.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 43, 42, 42)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                       color: const Color.fromARGB(255, 27, 26, 26)
                    ),
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
            
                       border: InputBorder.none,
                        labelText: 'Enter a valid email'
                        
                        // labelStyle: TextStyle()
                        
                        ),
                    ),
                  ),
                ),
            
              const SizedBox(height: 16.0),
              Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 27, 26, 26)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromARGB(255, 27, 26, 26)
                    ),
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
            
                       border: InputBorder.none,
                        labelText: 'Create a password'
                        
                        // labelStyle: TextStyle()
                        
                        ),
                    ),
                  ),
                ),
              
              const SizedBox(height: 16.0),
              Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 27, 26, 26)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromARGB(255, 27, 26, 26)
                    ),
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
            
                       border: InputBorder.none,
                        labelText: 'Create a username'
                        
                        // labelStyle: TextStyle()
                        
                        ),
                    ),
                  ),
                ),
                     
              const SizedBox(height: 16.0),
               Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 27, 26, 26)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromARGB(255, 27, 26, 26)
                    ),
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
            
                       border: InputBorder.none,
                        labelText: 'Enter your bio'
                        
                        // labelStyle: TextStyle()
                        
                        ),
                    ),
                  ),
                ),
              
              const SizedBox(height: 130),
              Row(
                children: [
                  Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    
                    onPressed: (){
                      _handleSignUp();
                      FocusScope.of(context).unfocus();
                    },
                    child: isLoading ? const Center(child: CircularProgressIndicator(
                      color: primaryColor,
                    ),)
                    
                    : const Text('Sign in'),
                  ),
                ),
              ),
                ],
              )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
