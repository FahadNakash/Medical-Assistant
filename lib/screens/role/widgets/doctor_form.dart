import 'package:flutter/material.dart';
import 'package:patient_assistant/components/button_with_icon.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/data/country_data.dart';
import 'package:patient_assistant/data/practiceData.dart';
import '../widgets/form_heading.dart';
import '../../../components/custom_input_field.dart';
import '../../../components/custom_drop_down.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import '../../../components/selection_chip.dart';
import 'country_dropdown.dart';
class DoctorForm extends StatefulWidget {
  DoctorForm({Key? key}) : super(key: key);
  @override
  State<DoctorForm> createState() => _DoctorFormState();
}
class _DoctorFormState extends State<DoctorForm>{
  String name='';
  String? nameError;
  String? selectCountry;
  String? selectPractice;
  String? selectsubType;
  String workExperience='';
  String? workError;
  String appointmentFee='';
  String? appointmentError;
  final countryData = CountryData.countryInfo;
  final practiceData = PracticeData.practiceType;
  final practiceSubTypes = PracticeData.practiceSubtypes;
  //final  List<SelectionChip> selectChips=[];
  final List<String> specialities = [];
  @override
  Widget build(BuildContext context){
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Container(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: (orientation==Orientation.portrait)?height*2:height*3
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FormHeading(text: 'Basic Info'),
          SizedBox(height: kDefaultHeight / 2),
          //Name Field
          CustomInputField(
              height: kDefaultHeight * 3.5,
              label: 'Name',
              onChanged: (string){

              },
              textAlign: TextAlign.center,
              helperText: 'Enter your full name'),
          SizedBox(height: kDefaultHeight / 2),
                    // Country Dropdown
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
                )),
              ],
            ),
          ),
                   //Phone number
          CustomInputField(
            height: kDefaultHeight * 3.5,
            label: 'Phone Number',
            textAlign: TextAlign.start,
            cursorHeight: 15,
            keyboardType: TextInputType.number,
            prefixText: (selectCountry == null)
                ? null
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '+${countryData[selectCountry]![0]}',
                      style: TextStyle(
                          color: kInputTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            helperText:
                'Please Provide a valid Number Where users can contact you',
          ),
          SizedBox(height: kDefaultHeight / 2),
          FormHeading(text: 'Professional Info'),
          SizedBox(height: kDefaultHeight / 2),
                 //practice dropdown
          PracticeDropDown(
              items: PracticeData.practiceType,
              label: 'Practice Type',
              selectItems: selectPractice,
              onChanged: (string) {
                selectPractice = string;
                setState(() {});
              }),
          SizedBox(height: kDefaultHeight / 2),
          Text('Please Select Your Practice Type',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 9,
                  )),
          SizedBox(height: kDefaultHeight / 2),
          if (selectPractice != null)
                //specialities dropdown
            PracticeSubType(
                items: practiceSubTypes[selectPractice]!,
                label: 'Specialities',
                selectItems: selectsubType,
                onChanged: (string) {
                  //selectChips.add(SelectionChip(label: 'fahad'));
                  if (string != null && !specialities.contains(string)) {
                    specialities.add(string);
                    print(specialities.length);
                    setState(() {});
                  }
                  print('select type is : $string');
                }),
          SizedBox(height: kDefaultHeight/2,),
          if (specialities.isNotEmpty)
               // chips selection
          Container(
             width: double.infinity,
            child: Column(
              children: [
                Wrap(
                  runSpacing: 10,
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: specialities.map((e) => SelectionChip(label: e,onTap: () {specialities.remove(e);
                              setState(() {}
                              );
                            }))
                        .toList()
                ),
                SizedBox(height: kDefaultHeight,)
              ],
            ),
          ),
              //work experince field
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(workError??'Enter your work experience in years',style: TextStyle(color: workError==null?kPrimaryColor:kErrorColor,fontSize: 11),),
                Spacer(),
                Container(
                  width: (orientation==Orientation.portrait)?100:200,
                  child: CustomInputField(
                    height: kDefaultHeight * 3.5,
                      label: '',
                      textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    onChanged: (string){
                       experienceValidation(string);
                       print(workExperience);
                        setState(() {
                        });
                    },
                  ),
                ),
              ],

            ),
          ),
          //appointment field
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(appointmentError??'Appointment Fee',style: TextStyle(color: appointmentError==null?kPrimaryColor:kErrorColor,fontSize: 11),),
                Spacer(),
                Container(
                  width: (orientation==Orientation.portrait)?150:250,
                  child: CustomInputField(
                    height: kDefaultHeight * 3.5,
                      label: '',
                      textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    suffix:(selectCountry==null)
                        ?null:
                    Text(
                      '${countryData[selectCountry]![1][0]}',
                      style: TextStyle(
                          color: appointmentError==null?kInputTextColor:kErrorColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onChanged: (string){
                       appointmentValidation(string);
                       print(appointmentFee);
                        setState(() {
                        });
                    },
                  ),
                ),
              ],

            ),
          ),
          //workplace name
          CustomInputField(
              height: kDefaultHeight * 3.5,
              label: 'WorkPlace Name', textAlign: TextAlign.start,helperText: 'Enter the name of your Workplace(e.g Hospital/Clinic)'),
           SizedBox(height: kDefaultHeight/2,),
          //workplace adress
          CustomInputField(
              height: kDefaultHeight * 3.5,
              label: 'WorkPlace Address', textAlign: TextAlign.start,helperText: 'Enter the address of your workplace'),
          SizedBox(height: kDefaultHeight/2),
          Column(
            children: [
              SizedBox(height: kDefaultHeight/2),
              Divider(color: kTextColor,),
              SizedBox(height: kDefaultHeight/2),
              ButtonWithIcon(width: 100,height: 30,defaultLinearGradient: true, textSize: 15, onPressed: (){}, text: 'Next', icon: Icons.arrow_forward, iconSize: 25)
            ],
          )

        ],
      ),
    );
  }
  experienceValidation(String string){
    if (string.isEmpty){
      workError='This field is required';
    }else if (string.length>2) {
      workError='Experience is too large';
    }else{
      workExperience=string;
      workError=null;
    }

  }
  appointmentValidation(String string){
    if (string.isEmpty){
      appointmentError='This  is  a required field';
    }else if (string.length>=5){
      appointmentError='Fee cannot be this much';
    }else{
      appointmentFee=string;
      appointmentError=null;
    }
  }
}
class PracticeDropDown extends StatelessWidget {
  final List<String> items;
  final String label;
  final String? selectItems;
  final Function(String?)? onChanged;
  const PracticeDropDown(
      {Key? key,
      required this.items,
      required this.label,
      required this.selectItems,
      required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      child: CustomDropDown(
        items: items,
        labelText: label,
        showSearchBox: false,
        mode: Mode.MENU,
        maxHeight: 100,
        contentPadding: EdgeInsets.only(left: 20, top: 10),
        popupItemBuilder: (BuildContext, String, bool) => Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Text((String == null) ? label : String.toString(),
                  style: TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: onChanged,
        dropdownBuilder: (selectItems == null)
            ? null
            : (BuildContext, String, string) {
                return Text(string,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: kInputTextColor),
                    textAlign: TextAlign.center);
              },
      ),
    );
  }
}
class PracticeSubType extends StatelessWidget {
  final List<String> items;
  final String label;
  final String? selectItems;
  final Function(String?)? onChanged;
  const PracticeSubType(
      {Key? key,
      required this.items,
      required this.label,
      required this.selectItems,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      child: CustomDropDown(
        items: items,
        labelText: label,
        showSearchBox: false,
        mode: Mode.MENU,
        maxHeight: 150,
        contentPadding: EdgeInsets.only(left: 20, top: 10),
        popupItemBuilder: (BuildContext, String, bool) => Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Text(String.toString(), style: TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: onChanged,
        dropdownBuilder: (BuildContext, String, bool) => Text('Specialities',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kInputTextColor),
            textAlign: TextAlign.center),
      ),
    );
  }
}
