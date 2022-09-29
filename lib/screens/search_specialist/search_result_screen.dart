import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import'../../components/custom_circle_progress_indicator.dart';
import '../../models/user_model.dart';
import '../../providers/practice_data.dart';
import '../../controllers/app_controller.dart';
import '../search_specialist/widgets/custom_filter_chip.dart';
import '../../constant.dart';
import '../search_specialist/widgets/doctor_detail_card.dart';
import '../../services/firestore_helper.dart';
import 'widgets/selected_filter_chip.dart';


class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final firestoreHelper=FirestoreHelper.firestoreGetter;
  final appController=AppController.appGetter;


  final List<String?> _specialities=Get.arguments['specialities'];
  final List<String?> _diseases=Get.arguments['diseases'];
  final String _country=Get.arguments['country'];

  int _remainingSpecialities=0;
  int _remainingDiseases=0;


  Future<List<List<dynamic>>> _filterDoctors()async{
    List<UserModel> doctors=await firestoreHelper.doctorsFilter(appController.user.uid);
    List<UserModel> filterDoctors=[];
    List<List<String>> matchedSp=[];

     if (_specialities.isEmpty && _diseases.isEmpty && _country.isEmpty){
       return [doctors.toList(),matchedSp];
     }
    for (var doctor in doctors){
      if (_country.isNotEmpty){
        if (doctor.doctor.country!=_country) {
          continue;
        }
      }
      if (_specialities.isNotEmpty){
        final List<String> sp=[];
        for (var speciality in doctor.doctor.specialities){
          if(_specialities.contains(speciality)){
            sp.add(speciality);
            if (!filterDoctors.contains(doctor)){
              filterDoctors.add(doctor);
              matchedSp.add(sp);
            }
          }
        }
      }
      if (_diseases.isNotEmpty){
        final List<String> d=[];
        for (var disease in _diseases){
          for (var speciality in doctor.doctor.specialities) {
            final _diagnoses=PracticeData.practiceDiagnosis[speciality]!;
            for (var diagnose in _diagnoses){
              if (diagnose==disease){
                if (!d.contains(diagnose)) {
                  d.add(diagnose);
                }
                if (!filterDoctors.contains(doctor)) {
                  filterDoctors.add(doctor);
                  matchedSp.add(d);
                }}}}}}
      if (_diseases.isEmpty && _specialities.isEmpty && _country.isNotEmpty) {
        if (doctor.doctor.country==_country) {
          filterDoctors.add(doctor);
        }
      }
    }
    return [filterDoctors,matchedSp];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          customSliverAppbar(context),
           _filterDoctorsList(context)
        ],
      ),
    );
  }

  Widget customSliverAppbar(BuildContext context){
    return  SliverAppBar(
      automaticallyImplyLeading: true,
      expandedHeight: 380,
      floating: true,
      backgroundColor:Colors.white,
      flexibleSpace:FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children:[
            Column(
            children: [
              Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    height: 370,
                    padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 20),
                    decoration:   const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                        gradient: LinearGradient(
                          colors:[
                            Color(0xFF218868),
                            Color(0xff36EA7B)
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        )
                    ),
                    child: _drawSelectedSpecialities(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
            Positioned(
              bottom: 10,
              child: Container(
                height: 40,
                width: 120,
                alignment: Alignment.center,
                decoration:   BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xf037e87f).withOpacity(0.8),
                      kPrimaryColor.withOpacity(0.8),
                    ],
                  )
                ),
                child:  const Text('Results',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Montserrat')),

              ),
            ),
          ],
        ),
      )

    );
  }
  Widget _drawSelectedSpecialities(){
    return Column(
      children: [
        _selectedCountryChip(),
        const SizedBox(height: kDefaultHeight,),
        Row(
          children:  [
            const Text('Specialities',style: kSearchHeading4,),
            const SizedBox(width: kDefaultWidth/2),
            Expanded(
              child: Container(
                height: 0.5,
                color: Colors.white.withOpacity(0.8),),
            ),
          ],
        ),
        const SizedBox(height: kDefaultHeight/2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
           Expanded(
             child: Wrap(
               alignment: WrapAlignment.center,
               runSpacing: 5,
               spacing: 5,
               children: _drawSpecialitiesRow(),
             ),
           ),
            const SizedBox(width: 10),
            if (_remainingSpecialities!=0)
            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (ctx)=>_showDialogue(title: 'Selected Specialities', middleContent: _specialities)
                );
              },
                child: Text('+$_remainingSpecialities',style: kSearchHeading4,))
          ],
        ),
        const SizedBox(height: kDefaultHeight),
        Row(
          children:  [
            const Text('Diseases',style: kSearchHeading4,),
            const SizedBox(width: kDefaultWidth/2),
            Expanded(
              child: Container(
                height: 0.5,
                color: Colors.white.withOpacity(0.8),),
            ),
          ],
        ),
        const SizedBox(height: kDefaultHeight/2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Expanded(
                child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 5,
              spacing: 5,
              children: _drawDiseasesRow(),
            )),
            const SizedBox(width: 10),
            if (_remainingDiseases!=0)
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (ctx)=>_showDialogue(title: 'Selected Diseases', middleContent: _diseases)
                  );
                },
                  child: Text('+$_remainingDiseases',style: kSearchHeading4,))
          ],
        ),
      ],
    );
  }
  Widget _selectedCountryChip(){
    return   Container(
      margin: const EdgeInsets.only(left: kDefaultPadding*1.5,),
      child: Row(
        children:   [
          const Text('In',style: kSearchHeading4,),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child:  Text(_country==''?'All Countries':'$_country only',style: const TextStyle(color: kPrimaryColor,fontFamily: 'Montserrat',fontSize: 16,fontWeight: FontWeight.w700,),),
          ),

        ],
      ),
    );

  }
  List<Widget> _drawSpecialitiesRow(){
    _remainingSpecialities=0;
    final List<Widget> _specialitiesChips=[];
   if (_specialities.isNotEmpty) {
     for(int i=0;i<_specialities.length;i++){
       if (i<3) {
         _specialitiesChips.add( SelectedFilterChip(label: _specialities[i]!),);
       }else{
         _remainingSpecialities++;
       }
     }
   }else{
     _specialitiesChips.add(const SelectedFilterChip(label: 'None Selected'));
   }

    return _specialitiesChips;
  }
  List<Widget> _drawDiseasesRow(){
    _remainingDiseases=0;
    final List<Widget> _diseasesChips=[];
    if (_diseases.isNotEmpty) {
      for(int i=0;i<_diseases.length;i++){
        if (i<3) {
          _diseasesChips.add( SelectedFilterChip(label: _diseases[i]!),);
        }else{
          _remainingDiseases++;
        }
      }
    }else{
      _diseasesChips.add(const SelectedFilterChip(label: 'None Selected'));
    }
    return _diseasesChips;
  }
  Widget _showDialogue({required String title,required List<String?> middleContent}){
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2,vertical: kDefaultPadding/3),
        height: 300,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Container(
             alignment:Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: kErrorColor,
                      shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.close,color: Colors.white,size: 20,)),
            ),
          ),
            const SizedBox(height: kDefaultHeight,),
            Text(title,style: const TextStyle(color: kInputTextColor,fontFamily: 'Comfortaa',fontSize: 18,fontWeight: FontWeight.bold)),
            const SizedBox(height: kDefaultHeight,),
              Expanded(
                child: Wrap(
                  spacing: 7,
                  runSpacing:10,
                  alignment: WrapAlignment.center,
                  children: middleContent.map((e) => CustomFilterChip(label: e!,onTap: (){},selectChip: true,)).toList(),
                ),
              ),

          ],
        ),
      ),

    );
  }

  Widget _filterDoctorsList(BuildContext context){
    return FutureBuilder<List<List<dynamic>>>(
      future:_filterDoctors(),
        builder: (context,snapShot){
        if (snapShot.connectionState==ConnectionState.waiting){
           return  const SliverToBoxAdapter(
               child: SizedBox(
                   height:300,
                   child: Center(child: CustomCircleProgressIndicator())));
        }
        if (snapShot.hasError) {
           return const SliverToBoxAdapter(child: Center(child: Text('"Oops" Something Wrong',style: TextStyle(fontSize: 15),)));
        }
        if (snapShot.hasData) {
          if (snapShot.data!=null) {
            final List<UserModel> doctors=snapShot.data![0] as List<UserModel>;
            final List<List<String>> filters=snapShot.data![1] as List<List<String>>;
            return doctors.isEmpty
                ?SliverToBoxAdapter(
                child: Column(
                children: [
                  SvgPicture.asset('assets/images/not_found.svg',),
                  const Text('No results found matching your query',style: TextStyle(fontSize: 15)),
                ],
              ),
            )
                :SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context, index) =>Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: DoctorDetailCard(doctorTile: doctors[index],filters:filters.isEmpty?[]:filters[index],country: _country,)),
                    childCount: doctors.length
                )
            );
          }
        }
           return const SliverToBoxAdapter(child: Center(child: Text('Something wrong',style: TextStyle(fontSize: 15))));
        }

    );
  }

}
