import 'package:flutter/material.dart';
import '../../components/side_drawer.dart';
import '../home/home_screen.dart';
import '../../constant.dart';
class DrawerHomeScreen extends StatelessWidget {
  const DrawerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
        return showExitDialogue(context);
      },
      child: Stack(
        children: const [
          HomeScreen(),
          SideDrawer(),
        ],
      ),
    );

  }


  Future<bool> showExitDialogue(BuildContext context) async{
    final _shouldPop=  await showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('WARNING',style:kDialogBoxTitle,textAlign: TextAlign.start,),
          content: const Text('Are you sure you want to exit Medical Assistant',style: kDialogBoxBody,textAlign:TextAlign.start, ),
          actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(child: const Text('Yes',style: TextStyle(color: Colors.white)), onPressed: ()=>Navigator.of(context).pop(true)
              ,color: kErrorColor,splashColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              const SizedBox(width: kDefaultWidth/2,),
              MaterialButton(child: const Text('No',style: TextStyle(color: Colors.white)), onPressed: ()=>Navigator.of(context).pop(false)
              ,color: kInputTextColor,splashColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),

            ],
          )
          ],
        )
    );

    return _shouldPop??false;
  }
}
