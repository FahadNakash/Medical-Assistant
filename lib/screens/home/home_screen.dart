import 'package:flutter/material.dart';
import 'package:patient_assistant/screens/home/widgets/home_categories.dart';
import 'package:patient_assistant/screens/recommended_doctors.dart';

import '../home/widgets/custom_app_bar.dart';
import '../../controllers/app_controller.dart';
import '../../screens/home/widgets/daily_quotes.dart';
import '../../screens/home/widgets/home_categories.dart';

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
            backgroundColor: Colors.white,
            expandedHeight: 230,
            flexibleSpace:FlexibleSpaceBar(
              background:  CustomAppBar(),
            ),
          ),
          const SliverToBoxAdapter(
            child:DailyQuotes(),
          ),
           SliverToBoxAdapter(
            child: HomeCategories(),
          ),
           SliverToBoxAdapter(
            child: RecommendedDoctors()
            ,),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: Colors.tealAccent,
            )
            ,)



        ],
      ),
    );
  }
}

