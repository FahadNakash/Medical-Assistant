import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';



import '../home/widgets/custom_app_bar.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/role_controller.dart';
import '../../routes/app_pages.dart';
import '../../screens/home/widgets/daily_quotes.dart';
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
            child:DailyQuotes(),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 700,
              color: Colors.yellow,
            ),
          )


        ],
      ),
    );
  }
}

