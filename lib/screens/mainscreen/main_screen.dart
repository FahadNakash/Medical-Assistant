import 'package:flutter/material.dart';
import '../../components/side_drawer.dart';
import '../home/home_screen.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
