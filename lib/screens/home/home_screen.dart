import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_assistant/routes/app_pages.dart';

import '../../screens/recommended_doctors.dart';
import '../../screens/home/widgets/navigator_tile.dart';
import '../../screens/home/widgets/home_categories.dart';
import '../../constant.dart';
import '../home/widgets/custom_app_bar.dart';
import '../../screens/home/widgets/daily_quotes.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
            child: NavigatorTile(
              title: 'Drugs Info.',
              subtitle: 'Search Drugs for their uses,side effects and their interaction with other drugs',
              imagePath: '$kAssets/pills.svg',
              iconColor:  const Color(0xff6AD9DA),
              onTap: (){
                Get.toNamed(Routes.search_drug);
              },
            )
            ,),
           SliverToBoxAdapter(
            child: NavigatorTile(
              title: 'Disease Info.',
              subtitle: 'Search Disease for their category,effects on body and other useful information about them',
              imagePath: '$kAssets/virus.svg',
              iconColor:  const Color(0xff8F97D3),
              onTap: (){
                Get.toNamed(Routes.search_disease);
              },
            )
            ,),
           SliverToBoxAdapter(
            child: NavigatorTile(
              title: 'My Profile',
              subtitle: 'View and edit your profile information',
              imagePath: '$kAssets/user.svg',
              iconColor:  const Color(0xffFFA88D),
              onTap: (){
                Get.toNamed(Routes.user_profile,);
              },
            )
            ,)

        ],
      ),
    );
  }
}

