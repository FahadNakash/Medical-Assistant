import 'dart:io';
import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';


import '../../../models/doctor_model.dart';
import '../../../providers/practiceData.dart';
import '../../../components/selection_chip.dart';
import '../../../components/custom_circle_progress_indicator.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/user_profile_controller.dart';
import '../widgets/edit_text_field.dart';
import '../../../components/app_button.dart';
import '../widgets/custom_edit_drop_down.dart';
import '../../../constant.dart';

class DoctorProfile extends StatefulWidget {
    File? newSelectImage;
    final Function clearNewImagePath;
    DoctorProfile({
    required this.newSelectImage,
      required this.clearNewImagePath,
    Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final userProfileController = UserProfileController.userProfileController;
  final appController = AppController.appGetter;


  bool _isLoading=false;

  final Doctor _doctor=Doctor();

  String? _nameError;
  String? _cityError;
  String? _phoneError;
  String? _appointmentFeeError;
  String? _workPlaceNameError;
  String? _workPlaceAddressError;

  @override
  void initState(){
      _doctor.name=appController.user.doctor.name;
      _doctor.country=appController.user.doctor.country;
      _doctor.phoneNumber=appController.user.doctor.phoneNumber;
      _doctor.city=appController.user.doctor.city;
      _doctor.practiceType=appController.user.doctor.practiceType;
      _doctor.specialities=appController.user.doctor.specialities.toList();
      _doctor.experience=appController.user.doctor.experience;
      _doctor.appointmentFee=appController.user.doctor.appointmentFee;
      _doctor.workplaceName=appController.user.doctor.workplaceName;
      _doctor.workplaceAddress=appController.user.doctor.workplaceAddress;
    super.initState();
  }

  bool get _showButton{
    return _doctor.name==appController.user.doctor.name && widget.newSelectImage==null &&
        _doctor.country==appController.user.doctor.country &&
        _doctor.city ==appController.user.doctor.city &&
        _doctor.phoneNumber.contains(appController.user.doctor.phoneNumber) &&
        _doctor.specialities.length<=2&&
        _doctor.experience==appController.user.doctor.experience &&
        _doctor.appointmentFee==appController.user.doctor.appointmentFee &&
        _doctor.workplaceName==appController.user.doctor.workplaceName &&
        _doctor.workplaceAddress==appController.user.doctor.workplaceAddress;
  }

  bool get _canProceed{
    return _nameError==null && _cityError==null && _phoneError==null && _appointmentFeeError==null && _workPlaceNameError==null &&_workPlaceAddressError==null;

  }

  _nameValidation(){
    if (_doctor.name.isEmpty){
      _nameError='Please enter the name';
    }else if (!RegExp('^[a-zA-Zs]+\$').hasMatch(_doctor.name)){
      _nameError='This is not valid';
    }else{
      return _nameError=null;
    }


  }
  _cityValidation() {
    if (_doctor.city.isEmpty) {
      _cityError = 'This is a required field';
    }else if (_doctor.city.contains(' ')){
      _cityError='White-Spaces does not allow';
    }else {
      _cityError = null;
    }
  }
  _phoneValidation() {
    if (_doctor.phoneNumber.isEmpty) {
      _phoneError = 'Please provide contact number';
    } else if (_doctor.phoneNumber.length < 5) {
      _phoneError = 'phone number is to short';
    }else if (_doctor.phoneNumber.contains(' ')){
      _phoneError='White-Spaces does not allow';
    }else if(!RegExp(r'^[0-9]+$').hasMatch(_doctor.phoneNumber)){
      _phoneError='invalid number ';
    } else {
      _phoneError = null;
    }
  }
  _appointmentValidation() {
    if (_doctor.appointmentFee.isEmpty) {
      _appointmentFeeError = 'This  is  a required field';
    } else if (_doctor.appointmentFee.length > 3) {
      _appointmentFeeError = 'Fee cannot be this much';
    }else if(_doctor.appointmentFee.contains(' ')){
      _appointmentFeeError='White-Spaces does not allowed';
    }else if (!RegExp(r'^[0-9]+$').hasMatch(_doctor.appointmentFee)) {
      _appointmentFeeError='fee must be a number';
    }else {
      _appointmentFeeError = null;
    }
  }
  _workPlaceNameValidation(){
    if (_doctor.workplaceName.isEmpty) {
      _workPlaceNameError='This is a required field';
    }else if(_doctor.workplaceName.contains(' ')){
      _workPlaceNameError='White-Spaces does not allowed';
    }
    else{
      _workPlaceNameError=null;
    }

  }
  _workPlaceAddressValidation(){
    if (_doctor.workplaceAddress.isEmpty) {
      _workPlaceAddressError='This is a required field';
    }else{
      _workPlaceAddressError=null;
    }

  }

  _allFieldsValidation(){
    _nameValidation();
    _cityValidation();
    _phoneValidation();
    _appointmentValidation();
    _workPlaceNameValidation();
    _workPlaceAddressValidation();
    setState(() {});
  }

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
          //name field
          EditTextField(
              title: 'Name',
              errorText: _nameError,
              initialValue:_doctor.name,
              onChanged: (v) {
                _doctor.name=v.trim();
                setState(() {});
              }),
          errorMessage(_nameError),
          const SizedBox(height: kDefaultHeight/6),
          // country dropdown
          CustomEditDropDown<String>(
            maxHeight: 300,
            title: 'Country',
            showSearchBox: true,
            mode: Mode.DIALOG,
            selectItem: _doctor.country,
            onChanged: (v) {
              _doctor.country= v!;
              setState(()=>{});
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
            dropdownSearchBuilder: (_doctor.country==appController.user.doctor.country)
                ?(context, string, b)=>Text(_doctor.country,
                style: const TextStyle(color: kInputTextColor, fontSize: 15),
            )
                :(context, string, b)=>Text(
                      string!,
                      style: const TextStyle(color: kInputTextColor, fontSize: 15),
                    ),
          ),
          const SizedBox(height: kDefaultHeight),
          // city field
          EditTextField(
              errorText: _cityError,
              title: 'City',
              initialValue: _doctor.city,
             onChanged: (v){
                _doctor.city=v.trim();
                setState(() {});
            },
          ),
          errorMessage(_cityError),
          const SizedBox(height: kDefaultHeight/3),
          //phone field
          EditTextField(
              errorText: _phoneError,
              title: 'Phone No',
              prefixText:'+${userProfileController.countryInfo[_doctor.country]![0]}',
              initialValue: _doctor.phoneNumber,
              onChanged: (v){
                _doctor.phoneNumber=v.trim();
                setState((){});
              },
          ),
          errorMessage(_phoneError),
          const SizedBox(height: kDefaultHeight/2),
          //practice type
          CustomEditDropDown<String>(
              maxHeight: 100,
              title:' Practice \n Type',
              showSearchBox: false,
              mode: Mode.MENU,
              items: PracticeData.practiceType,
              onChanged: (v){
              _doctor.practiceType=v!;
              if (_doctor.practiceType==appController.user.doctor.practiceType){
                if (_doctor.specialities.any((element) => appController.user.doctor.specialities.contains(element))){
                  return null;
                }else{
                  _doctor.specialities.clear();
                  setState(()=>{});
                }
              }
              _doctor.specialities=[];
              setState(()=>{});
            },
            popUpItemBuilder: (context, string, b) => Container(
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
            dropdownSearchBuilder:(_doctor.practiceType==appController.user.doctor.practiceType)
                ?(context, string, b)=>Text(_doctor.practiceType,
              style: const TextStyle(color: kInputTextColor, fontSize: 15),
            )
                :(context, string, b)=>Text(
                string!,
                style: const TextStyle(color: kInputTextColor, fontSize: 15),
              )
          ),
          const SizedBox(height: kDefaultHeight),
          // Specialities
          CustomEditDropDown<String>(
            maxHeight: 300,
            title:' Specialities',
            showSearchBox: false,
            mode: Mode.MENU,
            items: PracticeData.practiceSubtypes[_doctor.practiceType],
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
              if (!_doctor.specialities.contains(v!)){
                _doctor.specialities.add(v);
                setState(() => {});
               }
              },
            dropdownSearchBuilder:(_doctor.practiceType==appController.user.doctor.practiceType && _doctor.specialities.length == appController.user.doctor.specialities.length )
                  ?(context, string, b)=>Text('"${appController.user.doctor.specialities.length} Select"',
                style: const TextStyle(color: kTextColor, fontSize: 15),
              )
                  :(context, string, b)=>Text(
                '"${_doctor.specialities.length} Select"',
                style: const TextStyle(color: kTextColor, fontSize: 15),
              )
          ),
          const SizedBox(height: kDefaultHeight),
          Wrap(
            runSpacing: 10,
            spacing: 5,
            children:
          _doctor.specialities.map((element)=>SelectionChip(
                  label:element,
                  icon: const Icon(Icons.remove_circle_outline),
                  onTap: (){
                    _doctor.specialities.remove(element);
                    setState(()=>{});
                  },)).toList()
          ),
          const SizedBox(height: kDefaultHeight*1.5),
          //work experience
          experienceTextField(),
          const SizedBox(height: kDefaultHeight),
          //appointment fee
          EditTextField(
              errorText: _appointmentFeeError,
              initialValue: _doctor.appointmentFee,
              title: 'Appointment\nFree',
              prefixText: '${userProfileController.countryInfo[_doctor.country]![1][0]}',
              onChanged: (v){
                _doctor.appointmentFee=v;
                setState(() {});
              },
          ),
          errorMessage(_appointmentFeeError),
          const SizedBox(height: kDefaultHeight/3),
          EditTextField(
              errorText: _workPlaceNameError,
              initialValue:_doctor.workplaceName,
              title: 'WorkPlace \nName',
              onChanged: (v){
                _doctor.workplaceName=v;
                setState(() {
                });
              },
          ),
          errorMessage(_workPlaceNameError),
          const SizedBox(height: kDefaultHeight/2),
          EditTextField(
              errorText: _workPlaceAddressError,
              initialValue:_doctor.workplaceAddress,
              title: 'WorkPlace \nAddress',
              onChanged: (v){
                _doctor.workplaceAddress=v;
                setState(() {
                });
              },
          ),
          errorMessage(_workPlaceAddressError),
              if (!_showButton)
                _isLoading?const CustomCircleProgressIndicator():AppButton(
                text: 'Update',
                height: 35,
                width: 70,
                onPressed: ()async{
                  _allFieldsValidation();
                  if(_canProceed){
                   setState(() {
                     _isLoading=true;
                   });
                   try{
                     await userProfileController.updateDoctorProfile(doctor: _doctor,newImage: widget.newSelectImage,oldImage: appController.user.imageFile);
                     widget.clearNewImagePath();
                   }catch(e){
                     print(e);
                   }
                  // if (widget.newSelectImage!=null) {
                  //   precacheImage(FileImage(widget.newSelectImage!),context);
                  // }
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
  Widget experienceTextField(){
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding*5),
      child: Row(
        children: [
          const SizedBox(
              width: kDefaultWidth*6,
              child: Text('Work \nExperience:',style: TextStyle(fontSize: 13,color: kHeading2Color,fontWeight: FontWeight.w500))),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        if (int.parse(_doctor.experience)!=0){
                          var _decrement=int.parse(_doctor.experience);
                        _decrement--;
                        _doctor.experience=_decrement.toString();
                        setState(() {});
                        }
                      },
                      child: const Icon(Icons.remove,color: kInputTextColor)
                  ),
                  Text(_doctor.experience.toString(),style: const TextStyle(color: kPrimaryColor,fontSize: 15),),
                  GestureDetector(
                      onTap: (){
                        var _increment=int.parse(_doctor.experience,);
                        _increment++;
                        _doctor.experience=_increment.toString();
                        setState(() {});
                      },
                      child: const Icon(Icons.add,color: kInputTextColor,)
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  Widget errorMessage(String? errorText){
    return Container(
        margin: const EdgeInsets.only(left: 80),
        child: Text(errorText??'',style: TextStyle( color: errorText==null?kPrimaryColor:kErrorColor,fontSize: 10,),));
  }


}



