import 'dart:io';

import 'package:flutter/material.dart';



import '../home/widgets/custom_app_bar.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/role_controller.dart';
import '../../routes/app_pages.dart';
import '../../screens/home/widgets/daily_quotes.dart';
import '../../utilities/utils.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final appController=AppController.appGetter;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            //  shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30)), ),
            backgroundColor: Colors.white,
            expandedHeight: 230,
            flexibleSpace:FlexibleSpaceBar(
              background:  CustomAppBar(),

            ),
          ),
          SliverToBoxAdapter(
            child:Container(
                child: DailyQuotes()),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: Colors.yellow,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                  ),
                  FlatButton(onPressed: ()
                  {
                    Utils().getImageLocally();
                    },child: Text('press me')),
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
}

