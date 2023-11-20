import 'package:flutter/material.dart';
import 'package:riverpod/utilis/global_variable.dart';
class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _currentIndex = 0;

  @override
  void initState() {

    super.initState();
    allPages;
  }


  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: allPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, // Ensure all labels are visible
        items: [
          BottomNavigationBarItem(
            icon:_currentIndex == 0 ? Icon(
              
              Icons.home,
              color:  Colors.white,// : Colors.grey, // White for selected, grey for unselected
               size: 30,
            ):Icon(
              Icons.home_outlined,
              color:  Colors.white,
                size: 30,
                 )
            ,
            label: '', // Remove label
          ),
          BottomNavigationBarItem(
            icon:_currentIndex == 1 ? Icon(
              
              Icons.search,
              color:  const Color.fromARGB(255, 255, 244, 244),// : Colors.grey, // White for selected, grey for unselected
               size: 30,
            ):Icon(
              Icons.search_sharp,
              color:  Colors.white,
                size: 35,
                 )
            ,
            label: '', // Remove label
          ),
          BottomNavigationBarItem(
            icon:_currentIndex == 2 ? Icon(
              
              Icons.add,
              color:  Colors.white,// : Colors.grey, // White for selected, grey for unselected
               size: 30,
            ):Icon(
              Icons.add_rounded,
              color:  Colors.white,
                size: 30,
                 )
            ,
            label: '', // Remove label
          ),
          BottomNavigationBarItem(
            icon:_currentIndex == 3 ? Icon(
              
              Icons.favorite_outlined,
              color:  Colors.white,// : Colors.grey, // White for selected, grey for unselected
               size: 30,
            ):Icon(
              Icons.favorite_border_rounded,
              color:  Colors.white,
                size: 30,
                 )
            ,
            label: '', // Remove label
          ),
          BottomNavigationBarItem(
            icon:_currentIndex == 4 ? Icon(
              
              Icons.person,
              color:  Colors.white,// : Colors.grey, // White for selected, grey for unselected
               size: 30,
            ):Icon(
              Icons.person_outline,
              color:  Colors.white,
                size: 30,
                 )
            ,
            label: '', // Remove label
          ),


         
         
        ],
      ),
      
    );
  }
}
