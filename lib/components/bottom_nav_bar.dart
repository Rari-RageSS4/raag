import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
   final int selectedIndex;
   final Function(int) onTap;
   
   const BottomNavBar({super.key, 
   required this.selectedIndex, 
   required this.onTap
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: widget.onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 0, 80, 120),
          selectedItemColor: const Color.fromARGB(255, 0, 146, 219),
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Like'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings'
            ),
          ]
        );
  }
}