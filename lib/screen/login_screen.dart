import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod/resources/auth_methods.dart';
import 'package:riverpod/responsive/mobile_screen_layout.dart';
import 'package:riverpod/responsive/responsive_layout_screen.dart';
import 'package:riverpod/responsive/web_screen_layout.dart';
import 'package:riverpod/screen/SignUpScreen.dart';
import 'package:riverpod/utilis/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading=false;


  void _handleUserLogin() async{
  setState(() {
          _isLoading=true;
        });
     String res= await AuthMethods().loginUser(

        email:  _emailController.text, 
        password: _passwordController.text

      );
       if(res=='success'){
        _emailController.clear();
        _passwordController.clear();
        setState(() {
          _isLoading=false;
        });
        Navigator.of(context).pushReplacement(
  MaterialPageRoute(
    builder: (_) {
      return const Responsive(
        MobileScreenLayout: MobileScreenLayout(),
        WebScreenLayout: WebScreenLayout(),
      
        );
    },
  ),
);
       }
       showSnackbar(res, context);

  
  }

  @override
  Widget build(BuildContext context) {
    final mq=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: <Widget>[
              SizedBox(height: 50,),
              Text("English (india)"),
              SizedBox(height: 100,),
              
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.instagram,
                      size: 80,
                      // color: const Color.fromARGB(255, 230, 93, 84),
                    )
                  ],
              ) ,
      
              
       SizedBox(height: 100,),
      
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
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
                      labelText: 'email'
                      
                      // labelStyle: TextStyle()
                      
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
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
                      labelText: 'password'
                      
                      // labelStyle: TextStyle()
                      
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
             Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue,
        ),
        height: 50,
        child: Row(
          children: [
        Expanded(
          child: TextButton(
            onPressed: _handleUserLogin,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.transparent),
                  )
                : const Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ),
          ],
        ),
      ),
       const SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Forgotton Password?",style: TextStyle(
          fontSize: 16,
          color: Colors.white,fontWeight: FontWeight.bold),)],),
      
              const SizedBox(height: 20.0),
      SizedBox(
        height: mq.height*0.2,
      ),
       Container(
        
        decoration: BoxDecoration(
          border: Border.all(
                      color: Colors.blue.shade300
                    ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 27, 27, 27),
        ),
        height: 50,
        child: Row(
          children: [
        Expanded(
          child: TextButton(
            onPressed: (){
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.transparent),
                  )
                : const Text('Create new account',style: TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(255, 102, 175, 234),fontWeight: FontWeight.bold),),
          ),
        ),
          ],
        ),
      ),
      
             
            ],
          ),
        ),
      ),
    );
  }
}
