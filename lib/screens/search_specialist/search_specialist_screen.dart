import 'package:flutter/material.dart';

import '../../constant.dart';
import '../search_specialist/widgets/filter_selection.dart';
class SearchSpecialistScreen extends StatelessWidget {
  const SearchSpecialistScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppbar(),
          body:SingleChildScrollView(
            child: Column(
              children:  const [
                FilterSelection(),
              ],
            ),
          )
      ),
    );

  }

}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
        Container(
        width: double.infinity,
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            colors:[
              kPrimaryColor,
              kInputTextColor,
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [
              0.2,
              1
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(icon: const Icon(Icons.arrow_back,color: Colors.white),onPressed: (){Navigator.of(context).pop();},),
            Container(
                margin: const EdgeInsets.only(left: kDefaultPadding*1.5),
                child: const Text('Search Specialist',style: kSearchHeading1,))
          ],
        ),
      )

        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(90);
}
