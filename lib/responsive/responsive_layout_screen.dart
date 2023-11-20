import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/providers/user_provider.dart';
import 'package:riverpod/utilis/global_variable.dart';


class Responsive extends StatefulWidget {
  
   
   final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  const Responsive({super.key, required this.WebScreenLayout, required this.MobileScreenLayout});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    addData();

  }
  addData()async{
    UserProvider _userProvider=
    Provider.of(context,listen: false);

    await _userProvider.refresUser();
  }


  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (context, Constraints){
        if(Constraints.maxHeight>webscreenSize){
          print(Constraints.maxHeight);
          return widget.WebScreenLayout;

        }
        print(Constraints.maxHeight);
        return widget.MobileScreenLayout;
      }
    
      );
  }
}