import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../screens/recommended_doctors.dart';
import '../../screens/home/widgets/navigator_tile.dart';
import '../../screens/home/widgets/home_categories.dart';
import '../../constant.dart';
import '../home/widgets/custom_app_bar.dart';
import '../../screens/home/widgets/daily_quotes.dart';
import 'widgets/alarm_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            expandedHeight: 230,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppBar(),
            ),
          ),
          const SliverToBoxAdapter(
            child: DailyQuotes(),
          ),
          SliverToBoxAdapter(
            child: HomeCategories(),
          ),
          const SliverToBoxAdapter(
            child: RecommendedDoctors()
            ,),
          SliverToBoxAdapter(
            child: NavigatorTile(
              title: 'Drugs Info.',
              subtitle: 'Search Drugs for their uses,side effects and their interaction with other drugs',
              imagePath: '$kAssets/pills.svg',
              backgroundColor: const Color(0xff6AD9DA),
              onTap: () {
                Get.toNamed(Routes.search_drug);
              },
            )
            ,),
          SliverToBoxAdapter(
            child: NavigatorTile(
              title: 'Disease Info.',
              subtitle: 'Search Disease for their category,effects on body and other useful information about them',
              imagePath: '$kAssets/virus.svg',
              backgroundColor: const Color(0xff8F97D3),
              onTap: () {
                Get.toNamed(Routes.search_disease);
              },
            )
            ,),
          SliverToBoxAdapter(
            child: NavigatorTile(
              title: 'My Profile',
              subtitle: 'View and edit your profile information',
              imagePath: '$kAssets/user.svg',
              backgroundColor: const Color(0xffFFA88D),
              onTap: () {
                Get.toNamed(Routes.user_profile,);
              },
            )
            ,),
          SliverToBoxAdapter(
            child: Divider(
                color: kGrey.withOpacity(0.5), endIndent: 50, indent: 30),
          ),
          SliverToBoxAdapter(
            child: NavigatorTile(
              title: 'Alarms',
              subtitle: 'Add Reminders for your Medications or Appointments',
              imagePath: '$kAssets/alarm.svg',
              backgroundColor: Colors.white,
              iconColor: Colors.red,
              height: 35,
              width: 30,
              showOutlineButton: true,
              showBorder: false,
              onTap: () {
                _settingModalBottomSheet(context);
               // Get.bottomSheet(
                //     const AlarmSheet(),
                //     ignoreSafeArea: true,
                //     enableDrag: true,
                //     isScrollControlled: true,
                //     backgroundColor: Colors.white,
                //     shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //             topRight: Radius.circular(20),
                //             topLeft: Radius.circular(20)),
                //         side: BorderSide(color: kPrimaryColor, width: 2)),
                // );
              },
            )
            ,)
        ],
      ),
    );
  }
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),side: BorderSide(color: kPrimaryColor,width: 2)),
        builder: (BuildContext ctx){
          return const AlarmSheet();
        }
    );
  }


}

