import 'package:flutter/material.dart';
import '../constant.dart';
class CircleIconButton extends StatelessWidget {
  final Widget icon;
  final List<Color> colors;
  final VoidCallback onTap;
  const CircleIconButton({Key? key,required this.icon,required this.colors,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
          gradient: LinearGradient(
            colors:colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // stops: [
            //   0.5,
            //   0.0,
            // ],
          ),
        ),
        child: icon,
      ),
    );
  }
}
