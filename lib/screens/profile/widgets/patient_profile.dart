import 'dart:io';

import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_assistant/components/custom_circle_progress_indicator.dart';
import 'package:patient_assistant/components/selection_chip.dart';
import 'package:patient_assistant/models/patient_model.dart';

import '../../../components/app_button.dart';
import '../../../constant.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/user_profile_controller.dart';
import 'custom_edit_drop_down.dart';
import 'edit_text_field.dart';
class PatientProfile extends StatefulWidget {
  final File? newSelectImage;
  final Function clearNewImagePath;
  const PatientProfile({required this.newSelectImage,required this.clearNewImagePath,Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile>{
  final userProfileController = UserProfileController.userProfileController;
  final appController = AppController.appGetter;

  late FocusNode _focusNode;
  final TextEditingController disease=TextEditingController();

  bool _isExpand=false;
  bool _isLoading=false;

  final Patient _patient=Patient();
  String? _nameError;
  String? _cityError;
  String? _ageError;

  @override
  void initState() {
    _focusNode = FocusNode();
    _patient.name=appController.user.patient.name;
    _patient.country=appController.user.patient.country;
    _patient.age=appController.user.patient.age;
    _patient.city=appController.user.patient.city;
    _patient.diseases=appController.user.patient.diseases.toList();
    super.initState();
  }

  bool get showButton{
    return (
        _patient.name==appController.user.patient.name
            && widget.newSelectImage==null
            &&_patient.age==appController.user.patient.age
            &&_patient.country==appController.user.patient.country
            &&_patient.city==appController.user.patient.city
            &&_patient.diseases.every((element) => appController.user.patient.diseases.contains(element))
    );
  }

  nameValidation(){
    if (_patient.name.isEmpty){
      _nameError='Please enter the name';
    }else if (!RegExp('^[a-zA-Zs]+\$').hasMatch(_patient.name)){
      _nameError='This is not valid';
    }else{
      return _nameError=null;
    }


  }
  cityValidation() {
    if (_patient.city.isEmpty) {
      _cityError = 'This is a required field';
    }else if (_patient.city.contains(' ')){
      _cityError='White-Spaces does not allow';
    }else {
      _cityError = null;
    }
  }
  ageValidation(){
    if (_patient.age==0) {
      _ageError='Age is required';
    }else if (_patient.age<10){
      _ageError='Age is too small';
    }else if (_patient.age>=100) {
      _ageError='Age is too large';
    }else{
      _ageError=null;
    }
  }

  allFieldsValidation(){
    nameValidation();
    cityValidation();
    ageValidation();
    setState(() {});
  }

  bool get _canProceed=>_nameError==null && _cityError==null &&_ageError==null && _patient.country.isNotEmpty;


  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      margin: (orientation == Orientation.portrait)
          ? const EdgeInsets.symmetric(horizontal: kDefaultPadding)
          : const EdgeInsets.symmetric(horizontal: kDefaultPadding * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EditTextField(
              title: 'Name',
              errorText: _nameError,
              initialValue:_patient.name,
              onChanged: (v) {
                _patient.name=v;
                setState(() {});
              }),
          errorMessage(_nameError),
          const SizedBox(height: kDefaultHeight/2),
          ageField(),
          const SizedBox(height: kDefaultHeight),
          CustomEditDropDown<String>(
            maxHeight: 300,
            title: 'Country',
            showSearchBox: true,
            mode: Mode.DIALOG,
            selectItem: _patient.country,
            onChanged: (v) {
              if (v!=null) {
                _patient.country=v;
                setState(()=>{});
              }
            },
            popUpItemBuilder: (context, string, s) => Container(
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
            items: userProfileController.countryInfo.keys.toList(),
            dropdownSearchBuilder: (_patient.country==appController.user.patient.country)
                ?(context, string, b)=>Text(_patient.country,
              style: const TextStyle(color: kInputTextColor, fontSize: 15),
            )
                :(context, string, b)=>Text(
              string!,
              style: const TextStyle(color: kInputTextColor, fontSize: 15),
            ),
          ),
          const SizedBox(height: kDefaultHeight),
          EditTextField(
            errorText: _cityError,
            title: 'City',
            initialValue: _patient.city,
            onChanged: (v){
              _patient.city=v;
              setState(() {
              });
            },
          ),
          errorMessage(_cityError),
          const SizedBox(height: kDefaultHeight/2),
          diseaseField(
              title: 'Diseases',
              addDisease: (){
            if (disease.text.isNotEmpty){
              if (!_patient.diseases.any((e) =>e==disease.text)) {
                _patient.diseases.add(disease.text);
                disease.clear();
                setState(() {});
              }
            }
            }
          ),
          const SizedBox(height: kDefaultHeight),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: _patient.diseases.map((e) =>SelectionChip(label: e,onTap: (){
              _patient.diseases.removeWhere((element) => element==e);
              setState(() {});
            },)).toList(),
          ),
          const SizedBox(height: kDefaultHeight),

          if (!showButton)
          _isLoading
              ?const CustomCircleProgressIndicator()
              :AppButton(
            text: 'Update',
            height: 35,
            width: 70,
            onPressed: ()async{
              allFieldsValidation();
              FocusScope.of(context).unfocus();
              if (_canProceed){
                setState(() {
                  _isLoading=true;
                });
                await userProfileController.updatePatientProfile(patient: _patient,newImage: widget.newSelectImage,oldImage:appController.user.imageFile);
                widget.clearNewImagePath();
                setState(() {
                  _isLoading=false;
                });
              }
            },
            defaultLinearGradient: true,
            textSize: 12,
          ),

        ],
      ),
    );
  }

  Widget errorMessage(String? errorText){
    return Container(
        margin: const EdgeInsets.only(left: 80),
        child: Text(errorText??'',style: TextStyle( color: errorText==null?kPrimaryColor:kErrorColor,fontSize: 10,),
        ));
  }

  Widget ageField(){
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding*5),
      child: Row(
        children: [
          Container(
              width: kDefaultWidth*5.6,
              padding: const EdgeInsets.only(right: 20),
              child: Text(_ageError??'Age',style: TextStyle(fontSize: 13,color:_ageError==null?kHeading2Color:kErrorColor,fontWeight: FontWeight.w500,overflow: TextOverflow.fade))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap:(_patient.age<=0)?null:(){
                    _patient.age--;
                    setState(() {
                    });
                  },
                  child: Icon(Icons.remove,color:_ageError==null? kHeading2Color:kErrorColor,size: 25,)
              ),
              const SizedBox(width: 8,),
              Text('${_patient.age}',style: const TextStyle(color: kInputTextColor,fontSize: 15),),
              const SizedBox(width: 8,),
              GestureDetector(
                  onTap: (){
                    _patient.age++;
                    setState(() {
                    });
                  },
                  child: Icon(Icons.add,color: _ageError==null?kHeading2Color:kErrorColor,size: 25,)
              )
            ],
          )
        ],
      ),
    );
  }

  Widget diseaseField({ required String title,required Function() addDisease}){
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: SizedBox(
                child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 13,
                        color:kHeading2Color,
                        fontWeight: FontWeight.w500))),
          ),
          const SizedBox(width: kDefaultWidth*2.5,),
          if (_isExpand)
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: disease,
              focusNode: _focusNode,
              enabled: true,
              autocorrect: true,
              showCursor: true,
              style: const TextStyle(
                  color: kInputTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              cursorColor: kHeading1Color,
              decoration: InputDecoration(
                hintText: 'Add Disease',
                hintStyle: const TextStyle(color: kTextColor,fontSize: 10),
                suffixIcon: GestureDetector(
                    onTap: addDisease,
                    child: const Icon(FontAwesomeIcons.bacteria,size: 20,color: kInputTextColor)),
                contentPadding: const EdgeInsets.only(bottom: 10),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: kTextColor, width: 0)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color:kHeading1Color,width: 0)),
                 ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
              splashColor: kInputTextColor,
              onTap: () {
              _isExpand=true;
              _focusNode.requestFocus();
              setState(() {
              });
              },
              child: Container(
                height: 40,
                width: _isExpand?40:130,
                decoration: BoxDecoration(
                  color: _isExpand?Colors.white:kInputTextColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _isExpand
                    ?const Icon(
                  Icons.edit,
                  color: kHeading2Color,
                )
                    :IntrinsicHeight(
                      child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                      Icon(
                        Icons.edit,
                        color: kHeading2Color,
                      ),
                      Text('Click Here',style: TextStyle(fontSize: 10),)
                  ],
                ),
                    ),
              )),
        ],
      ),
    );
  }




}
