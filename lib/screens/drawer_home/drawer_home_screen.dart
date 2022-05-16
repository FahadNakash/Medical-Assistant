import 'package:flutter/material.dart';
import '../../components/side_drawer.dart';
import '../home/home_screen.dart';
class DrawerHomeScreen extends StatelessWidget {
  const DrawerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeScreen(),
        SideDrawer(),
      ],
    );
  }
}
