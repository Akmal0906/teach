import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";

class MainPage extends StatelessWidget {
  const MainPage({super.key,required this.navigationShell,});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'profile'),

      ],
      currentIndex: navigationShell.currentIndex,
       onTap: (int index)=>navigationShell.goBranch(index),
      ),
    );
  }
}
