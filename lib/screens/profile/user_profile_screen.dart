import 'package:flutter/material.dart';

import '../../database/firebase.dart';
import '../../controllers/app_controller.dart';
class UserProfile extends StatelessWidget{
  final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;
  final appController=AppController.appGetter;
   UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userProfile'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(onPressed: (){
            cloudDbGetter.getCloudData(appController.user.uid!);
          }, icon: Icon(Icons.eighteen_mp))
        ],
      ),
      body: Container(
        color: Colors.yellow,
        height: 500,
      ),
    );
  }
}
