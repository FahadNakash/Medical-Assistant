import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_assistant/components/custom_circle_progress_indicator.dart';
import 'package:patient_assistant/components/selection_chip.dart';
import 'package:get/get.dart';
import '../../../components/button_with_icon.dart';
import '../../../components/custom_input_field.dart';
import '../../../constant.dart';
import '../../../data/country_data.dart';
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
  bool _isLoading=false;
  String name='';
  String? nameError;
  String age='';
  String? ageError;
  String city='';
  String? cityError;
  TextEditingController disease=TextEditingController();
  final List<String> diseaseList = [];
  final countryData = CountryData.countryInfo;
  String? selectCountry;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Container(
      height: 700,
      constraints: BoxConstraints(
        maxWidth: 500,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FormHeading(text: 'Basic Info'),
          SizedBox(height: kDefaultHeight / 2),
          //Name Field
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomInputField(
                textInputAction: TextInputAction.next,
                height: kDefaultHeight * 3,
                label: 'Name',
                textAlign: TextAlign.center,
                helperText: 'Enter your full name',
                errorText: nameError,
                onChanged:(string){
                  name=string.trim();
                  nameValidation();
                  setState(() {
                  });
              },
            ),
          ),
          SizedBox(height: kDefaultHeight / 2),
          // age field
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                Text(
                  ageError??"Enter Your Age",
                  style: TextStyle(color:ageError==null?kPrimaryColor:kErrorColor, fontSize: 17),
                ),
                Spacer(),
                Container(
                  width: (orientation == Orientation.portrait) ? 100 : 200,
                  child: CustomInputField(
                    height: kDefaultHeight * 3,
                    label: 'Age',
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged:(string){
                      age=string.trim();
                      ageValidation();
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
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CountryDropDown(
                    onChanged: (data) {
                      selectCountry = data;
                      setState(() {});
                    },
                    selectItems: selectCountry,
                  ),
                ),
                SizedBox(
                  width: kDefaultWidth / 2,
                ),
                Expanded(
                    child: CustomInputField(
                  height: kDefaultHeight * 3.2,
                  label: 'City',
                  textAlign: TextAlign.center,
                      errorText: cityError,
                      onChanged: (string){
                      city=string.trim();
                      cityValidation();
                      setState(() {
                      });
                      },
                )),
              ],
            ),
          ),
          FormHeading(text: 'Medical Conditions'),
          SizedBox(height: kDefaultHeight / 2),
          Text(kText,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.justify),
          SizedBox(height: kDefaultHeight),
          //Disease field
          Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: CustomInputField(
                height: kDefaultHeight*3,
                controller: disease,
                label: 'Disease',
                helperText: 'This is an optional field you can skip it if you want',
                textAlign: TextAlign.start,
                suffix: InkWell(
                    onTap: () {
                      if (!diseaseList.contains(disease.text) && disease.text.isNotEmpty) {
                        diseaseList.add(disease.text);
                        disease.clear();
                        setState(() {
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(7),
                      child: Icon(
                        FontAwesomeIcons.bacteria,
                        color: kInputTextColor,
                        size: 17,
                      ),
                    )),
                textInputAction: TextInputAction.next,
              )),
          SizedBox(height: kDefaultHeight / 2),
          // disease  chips
          Wrap(
              runSpacing: 10,
              spacing: 10,
              direction: Axis.horizontal,
            children:diseaseList.map((e) => SelectionChip(
              label: e,
              onTap: (){
                diseaseList.remove(e);
                setState(() {
                });
              },
            )).toList()
          ),
          SizedBox(height: kDefaultHeight/2),
          Obx(
                  ()=>(
                      roleController.selectImage.isNotEmpty
                      && name.isNotEmpty
                      && age.isNotEmpty
                      && selectCountry!=null
                      && city.isNotEmpty

                  )
                      ?Column(
                     children: [
                      SizedBox(height: kDefaultHeight / 2),
                      Divider(
                        color: kTextColor,
                      ),
                      SizedBox(height: kDefaultHeight / 2),
                      _isLoading?CustomCircleProgressIndicator():ButtonWithIcon(
                        width: 100,
                        height: 30,
                        defaultLinearGradient: true,
                        textSize: 15,
                        text: 'Next',
                        icon: Icons.arrow_forward,
                        iconSize: 25,
                        onPressed: () async{
                          setState(() {
                            _isLoading=true;
                          });
                          nameValidation();
                          cityValidation();
                          ageValidation();
                          setState(() {});
                         await formSubmit(name,age,selectCountry,city,diseaseList);
                         setState((){
                           _isLoading=false;
                         });
                        },
                      )
                    ],
                  )
                      :SizedBox())

        ],
      ),
    );
  }
  nameValidation() {
    if (name.isEmpty) {
      nameError = 'This is a required field';
    } else if (!RegExp('^[a-zA-Z\s]+\$').hasMatch(name)) {
      nameError = 'This is not valid';
    } else {
      nameError = null;
    }
  }
  ageValidation(){
    if (age.isEmpty) {
      ageError='Age is required';
    }else if (int.parse(age)<16){
      ageError ='age is too small';
    }else if (int.parse(age)>=100) {
      ageError='age is too large';
    }else{
      ageError=null;
    }
  }
  cityValidation() {
    if (city.isEmpty) {
      cityError = 'This is a required field';
    }else if (city.contains(' ')){
      cityError='White-Spaces does not allow';
    }else {
      cityError = null;
    }
  }
  Future<void> formSubmit(String name,String age,String? country,String city,[List<String>? disease])async{
    if (nameError==null && ageError==null && selectCountry!=null && cityError==null){
      // print(roleController.selectImage);
      // print(name);
      // print(age);
      // print(country);
      // print(city);
      // print(disease);
      await roleController.patientForm(name, country!, city, age, disease!);
    }


  }
}

