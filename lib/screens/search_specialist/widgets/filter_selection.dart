import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:patient_assistant/components/custom_dialog_box.dart';


import '../../../components/selection_chip.dart';
import '../../../constant.dart';
import '../../../controllers/app_controller.dart';
import '../widgets/custom_filter_chip.dart';
import '../../../providers/practice_data.dart';
import '../../profile/widgets/custom_edit_drop_down.dart';
import '../search_result_screen.dart';
import '../../../components/app_button.dart';



class FilterSelection extends StatefulWidget {
  const FilterSelection({Key? key}) : super(key: key);

  @override
  State<FilterSelection> createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection>{
  final appController=AppController.appGetter;
  final TextEditingController _disease=TextEditingController();

  bool _isCountrySelect=false;
  final List<String> _addFilterSpecialities=[];
  final List<String> _addFilterDisease=[];

  bool checkSelectedSpeciality(String e){
    return _addFilterSpecialities.contains(e);
  }
  bool checkSelectedDisease(String e){
    return _addFilterDisease.contains(e);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: kDefaultHeight,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:   [
              const Text('Add Filters',style: kSearchHeading2),
              const SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 0.5,
                  color: kTextColor.withOpacity(0.2),),
              ),
              const Icon(Icons.filter_list_sharp,color: kHeading2Color,)
            ],
          ),
          const SizedBox(height: kDefaultHeight,),
          _countryCheckBox(),
          const SizedBox(height: kDefaultHeight,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:   [
              Text((appController.user.role=='Doctor')?'Your Specialities':'Your Diseases',style: kSearchHeading3),
              const SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 0.5,
                  color: kTextColor.withOpacity(0.2),),
              ),
            ],
          ),
          const SizedBox(height: kDefaultHeight,),
          _drawSpecialitiesOrDiseasesBox(),
          const SizedBox(height: kDefaultHeight,),
          _drawSelectSpecialitiesRow(),
          const SizedBox(height: kDefaultHeight,),
          _drawSelectSpecialitiesBox(),
          const SizedBox(height: kDefaultHeight/3,),
          _drawAddDiseasesRow(),
          const SizedBox(height: kDefaultHeight/3,),
          _drawSelectDiseasesBox(),
          const SizedBox(height: kDefaultHeight,),
          AppButton(
              height: 40,
              width: 100,
              onPressed: ()async{
                bool _isInternetConnect=await InternetConnectionChecker().hasConnection;
                if (_isInternetConnect) {
                  Get.to(()=> const SearchResultScreen(),
                      arguments:{
                        'country': _isCountrySelect?appController.user.userCountry:'',
                        'diseases':_addFilterDisease,
                        'specialities':_addFilterSpecialities
                      });
                }else{
                  Get.dialog(
                      CustomDialogBox(
                          title: 'Connection Issue', middleText: 'Please Make Sure that your device connect to the internet', onPressed: (){Get.back();}));
                }

              },
              text: 'Search',
              textSize: 13,
              defaultLinearGradient: true,
            showIcon: true,
            buttonIcon: Icons.search,
          )
        ],
      ),
    );
  }

  Widget _countryCheckBox() =>Row(
   children: [
      Expanded(
         child: Text(
             'Search For Specialists ${appController.user.userCountry} only',
             style:TextStyle(color:_isCountrySelect ?kInputTextColor: kTextColor,
                 fontSize: 13,))),
     Checkbox(
       value: _isCountrySelect,
       shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(5),),
       ),
       fillColor: MaterialStateProperty.all(kInputTextColor),
       side: BorderSide(color: kTextColor.withOpacity(0.6),width: 2),
       onChanged: (value){
         setState(() {
           _isCountrySelect=!_isCountrySelect;
         });
       },
       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
     ),
   ],
 );

  Widget _drawSpecialitiesOrDiseasesBox()=>Wrap(
    spacing: 10,
    runSpacing: 10,
    children:(appController.user.role=='Doctor')
        ?appController.user.doctor.specialities.map((e) =>CustomFilterChip(
          label: e,
          onTap: (){
            if(!_addFilterSpecialities.contains(e)){
              _addFilterSpecialities.add(e);
              setState(() {});
            }else{
              _addFilterSpecialities.removeWhere((element) => element==e);
              setState(() {});
            }
          },
          selectChip: checkSelectedSpeciality(e),
        )).toList()
        :appController.user.patient.diseases.map((e) =>CustomFilterChip(
      label: e,
      onTap: (){
        if(!_addFilterDisease.contains(e)){
          _addFilterDisease.add(e);
          setState(() {});
        }else{
          _addFilterDisease.removeWhere((element) => element==e);
          setState(() {});
        }
      },
      selectChip: checkSelectedDisease(e),
    )).toList()
  );
  CustomEditDropDown<String> _drawSelectSpecialitiesRow() => CustomEditDropDown<String>(
        maxHeight: 300,
        title:'Select Specialities',
        showSearchBox: false,
        mode: Mode.MENU,
        items: PracticeData.allSubpractices,
        popUpItemBuilder:(context, string, b) =>Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(string.toString(),
                  style: const TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: (v){
          if (!_addFilterSpecialities.contains(v!)){
            _addFilterSpecialities.add(v);
            setState(() => {});
          }
        },
        dropdownSearchBuilder:(context, string, b)=>Text(
          '"${_addFilterSpecialities.length} Select"',
          style: const TextStyle(color: kTextColor, fontSize: 15),
        )
    );
  Widget _drawSelectSpecialitiesBox() => Wrap(
        runSpacing: 10,
        spacing: 5,
        children:
        _addFilterSpecialities.map((element)=>SelectionChip(
          label:element,
          icon: const Icon(Icons.remove_circle_outline),
          onTap: (){
            _addFilterSpecialities.remove(element);
            setState(()=>{});
          },)).toList()
    );
  Widget _drawAddDiseasesRow() =>Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        children: [
          const Flexible(
            flex: 1,
            child: SizedBox(
                child: Text(
                    'Add Diseases',
                    style: TextStyle(
                        fontSize: 13,
                        color:kHeading2Color,
                        fontWeight: FontWeight.w500))),
          ),
          const SizedBox(width: kDefaultWidth,),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _disease,
              enabled: true,
              autocorrect: true,
              showCursor: true,
              style: const TextStyle(
                  color: kInputTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              cursorColor: kHeading1Color,
              decoration: InputDecoration(
                hintText: 'Try "Cancer" or "Hepatitis"',
                hintStyle: const TextStyle(color: kTextColor,fontSize: 10),
                suffixIcon: GestureDetector(
                    onTap: (){
                      if (_disease.text.isNotEmpty){
                        if (!_addFilterDisease.any((e) =>e==_disease.text)){
                          _addFilterDisease.add(_disease.text);
                          _disease.clear();
                          setState(() {});
                        }
                      }
                    },
                    child: const Icon(FontAwesomeIcons.bacteria,size: 20,color: kInputTextColor)),
                contentPadding: const EdgeInsets.only(bottom: 10),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: kTextColor, width: 0)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color:kHeading1Color,width: 0)),
              ),
            ),
          ),
        ],
      ),
    );
  Widget _drawSelectDiseasesBox() =>Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: _addFilterDisease.map((e) =>SelectionChip(label: e,onTap: (){
        _addFilterDisease.removeWhere((element) => element==e);
        setState(() {});
      },)).toList(),
    );












}
