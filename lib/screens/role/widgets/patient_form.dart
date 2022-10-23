import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../models/patient_model.dart';
import '../../../components/selection_chip.dart';
import '../../../components/custom_circle_progress_indicator.dart';
import '../../../components/button_with_icon.dart';
import '../../../components/custom_input_field.dart';
import '../../../constant.dart';
import '../../../providers/country_data.dart';
import '../widgets/form_heading.dart';
import 'country_dropdown.dart';
import '../../../controllers/role_controller.dart';

class PatientForm extends StatefulWidget {
  const PatientForm({Key? key}) : super(key: key);
  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final roleController = RoleController.roleGetter;
   final String kText='Enter any Medical Condition or a Disease that you have,for which you are searching for a Specialist.Please try to use the correct Medical Term to explain your Disease.(you can add more than one disease)' ;


  bool _isLoading=false;
  final Patient _patient=Patient();
  String? nameError;
  String? ageError;
  String? cityError;
  TextEditingController disease=TextEditingController();

  final countryData = CountryData.countryInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    disease.dispose();
    super.dispose();
  }

  bool get _canProceed=>nameError==null&& _patient.name.isNotEmpty && ageError==null &&_patient.age!=0 && _patient.country.isNotEmpty && cityError==null &&_patient.city.isNotEmpty;

  nameValidation(){
    if (_patient.name.isEmpty) {
      nameError = 'This is a required field';
    } else if (!RegExp('^[a-zA-Zs]+\$',unicode: true).hasMatch(_patient.name)) {
      nameError = 'This is not valid';
    } else {
      nameError = null;
    }
  }
  ageValidation(){
    if (_patient.age==0) {
      ageError='Age is required';
    }else if (_patient.age<16){
      ageError ='age is too small';
    }else if (_patient.age>=100) {
      ageError='age is too large';
    }else{
      ageError=null;
    }
  }
  cityValidation(){
    if (_patient.city.isEmpty) {
      cityError = 'This is a required field';
    }else if (_patient.city.contains(' ')){
      cityError='White-Spaces does not allow';
    }else {
      cityError = null;
    }
  }
  fieldsValidation(){
    nameValidation();
    ageValidation();
    cityValidation();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      height: 700,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const FormHeading(text: 'Basic Info'),
          const SizedBox(height: kDefaultHeight / 2),
          //Name Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomInputField(
                textInputAction: TextInputAction.next,
                height: kDefaultHeight * 3,
                label: 'Name',
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                helperText: 'Enter your full name',
                errorText: nameError,
                onChanged:(v){
                  _patient.name=v.trim();
                  if (v.isNotEmpty){
                    nameValidation();
                  }else{
                   nameError=null;
                  }
                  setState((){});
              },
            ),
          ),
          const SizedBox(height: kDefaultHeight / 2),
          // age field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                Text(
                  ageError??"Enter Your Age",
                  style: TextStyle(color:ageError==null?kPrimaryColor:kErrorColor, fontSize: 17),
                ),
                const Spacer(),
                SizedBox(
                  width: (orientation == Orientation.portrait) ? 100 : 200,
                  child: CustomInputField(
                    height: kDefaultHeight * 3,
                    label: 'Age',
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged:(v){
                      _patient.age=int.parse(v.trim());
                      if (v.isEmpty){
                        ageValidation();
                      }else{
                        ageError=null;
                      }
                      setState(() {
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          //country dropdown
          Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CountryDropDown(
                    onChanged: (data) {
                      if (data!=null) {
                        _patient.country = data;
                        setState(() {});
                      }
                    },
                    selectItems: _patient.country.isEmpty?null:_patient.country,
                  ),
                ),
                const SizedBox(
                  width: kDefaultWidth / 2,
                ),
                Expanded(
                    child: CustomInputField(
                    height: kDefaultHeight * 3.2,
                    label: 'City',
                    textAlign: TextAlign.center,
                      errorText: cityError,
                      onChanged: (v){
                      _patient.city=v.trim();
                      if (v.isEmpty) {
                        cityValidation();
                      }else{
                        cityError=null;
                      }
                      setState(() {});
                      },
                )),
              ],
            ),
          ),
          const FormHeading(text: 'Medical Conditions'),
          const SizedBox(height: kDefaultHeight / 2),
          Text(kText,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.justify),
          const SizedBox(height: kDefaultHeight),
          //Disease field
          Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: CustomInputField(
                controller: disease,
                height: kDefaultHeight*3,
                label: 'Disease',
                helperText: 'This is an optional field you can skip it if you want',
                textAlign: TextAlign.start,
                suffix: InkWell(
                    onTap: () {
                      if (!_patient.diseases.contains(disease.text) && disease.text.isNotEmpty){
                        _patient.diseases.add(disease.text);
                        disease.clear();
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      child: const Icon(
                        FontAwesomeIcons.bacteria,
                        color: kInputTextColor,
                        size: 17,
                      ),
                    )),
                textInputAction: TextInputAction.next,
              )),
          const SizedBox(height: kDefaultHeight / 2),
          // disease  chips
          Wrap(
              runSpacing: 10,
              spacing: 10,
              direction: Axis.horizontal,
            children:_patient.diseases.map((e) => SelectionChip(
              label: e,
              onTap: (){
                _patient.diseases.remove(e);
                setState(() {
                });
              },
            )).toList()
          ),
          const SizedBox(height: kDefaultHeight/2),
          Obx(
                  ()=>(
                      roleController.selectImage.isNotEmpty
                      && _patient.name.isNotEmpty
                      && _patient.age !=0
                      && _patient.country.isNotEmpty
                      && _patient.city.isNotEmpty

                  )
                      ?Column(
                     children: [
                      const SizedBox(height: kDefaultHeight / 2),
                      const Divider(
                        color: kGrey,
                      ),
                      const SizedBox(height: kDefaultHeight / 2),
                      _isLoading?const CustomCircleProgressIndicator():ButtonWithIcon(
                        width: 100,
                        height: 30,
                        defaultLinearGradient: true,
                        textSize: 15,
                        text: 'Next',
                        icon: Icons.arrow_forward,
                        iconSize: 25,
                        onPressed: () async{
                          fieldsValidation();
                          setState(() {
                            _isLoading=true;
                          });
                          if (_canProceed){
                         await roleController.patientForm(patient: _patient);
                          }
                         setState((){
                           _isLoading=false;
                         });
                        },
                      )
                    ],
                  )
                      :const SizedBox()
          )
        ],
      ),
    );
  }

  }


