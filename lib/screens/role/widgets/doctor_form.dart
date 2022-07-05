import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_assistant/components/button_with_icon.dart';
import 'package:patient_assistant/components/custom_circle_progress_indicator.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/controllers/role_controller.dart';
import 'package:patient_assistant/models/doctor_model.dart';
import 'package:patient_assistant/providers/country_data.dart';
import 'package:patient_assistant/providers/practiceData.dart';
import '../widgets/form_heading.dart';
import '../../../components/custom_input_field.dart';
import '../../../components/custom_drop_down.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import '../../../components/selection_chip.dart';
import 'country_dropdown.dart';

class DoctorForm extends StatefulWidget {
  const DoctorForm({Key? key}) : super(key: key);
  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final roleController = RoleController.roleGetter;

  final Doctor _doctor=Doctor();

  String? nameError;
  String? cityError;
  String? phoneError;
  String? selectSubType;
  String? experienceError;
  String? appointmentError;
  String? workPlaceNameError;
  String? workPlaceAddressError;

  bool isLoading=false;

  final countryData = CountryData.countryInfo;
  final practiceData = PracticeData.practiceType;
  final practiceSubTypes = PracticeData.practiceSubtypes;

  bool get _canProceed=>
          nameError==null
          && cityError==null
          && _doctor.country.isNotEmpty
          && phoneError==null
          && _doctor.practiceType.isNotEmpty
          && _doctor.specialities.isNotEmpty
          && experienceError==null
          && appointmentError==null
          && workPlaceNameError==null
          && workPlaceAddressError==null;

  nameValidation() {
    if (_doctor.name.isEmpty) {
      nameError = 'This is a required field';
    } else if (!RegExp('^[a-zA-Zs]+\$',unicode: true).hasMatch(_doctor.name)) {
      nameError = 'This is not valid';
    } else {
      nameError = null;
    }
  }
  cityValidation(){
    if (_doctor.city.isEmpty) {
      cityError = 'This is a required field';
    }else if (_doctor.city.contains(' ')){
      cityError='White-Spaces does not allow';
    }else if (!RegExp('^[a-zA-Zs]+\$').hasMatch(_doctor.city)) {
      cityError='invalid city name';
    } else {
      cityError = null;
    }
  }
  phoneValidation() {
    if (_doctor.phoneNumber.isEmpty) {
      phoneError = 'Please provide contact number';
    } else if (_doctor.phoneNumber.length<5) {
      phoneError = 'phone number is to short';
    }else {
      phoneError = null;
    }
  }
  experienceValidation() {
    if (_doctor.experience.toString().isEmpty) {
      experienceError = 'This field is required';
    } else if (_doctor.experience.toString().length > 2) {
      experienceError = 'Experience is too large';
    }else if(_doctor.experience.toString().contains(' ')){
      experienceError='White-Spaces does not allowed';
    }else{
      experienceError = null;
    }
  }
  appointmentValidation() {
    if (_doctor.appointmentFee.isEmpty) {
      appointmentError = 'This  is  a required field';
    } else if (_doctor.appointmentFee.length > 3) {
      appointmentError = 'Fee cannot be this much';
    }else if(_doctor.appointmentFee.contains(' ')){
      appointmentError='White-Spaces does not allowed';
    }else {
      appointmentError = null;
    }
  }
  workPlaceNameValidation(){
    if (_doctor.workplaceName.isEmpty) {
      workPlaceNameError='This is a required field';
    }else if(_doctor.workplaceName.contains(' ')){
      workPlaceNameError='White-Spaces does not allowed';
    }
    else{
      workPlaceNameError=null;
    }

  }
  workPlaceAddressValidation(){
    if (_doctor.workplaceAddress.isEmpty) {
      workPlaceAddressError='This is a required field';
    }else{
      workPlaceAddressError=null;
    }

  }

  fieldsValidation(){
    nameValidation();
    cityValidation();
    phoneValidation();
    experienceValidation();
    appointmentValidation();
    workPlaceNameValidation();
    workPlaceAddressValidation();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    return Container(
      constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight:(orientation == Orientation.portrait) ? height * 2 : height * 3),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const FormHeading(text: 'Basic Info'),
          const SizedBox(height: kDefaultHeight / 2),
          //Name Field
          CustomInputField(
              height: kDefaultHeight * 3.5,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              label: 'Name',
              errorText: nameError,
              onChanged: (v) {
                _doctor.name = v.trim();
                if (v.isNotEmpty){
                  nameValidation();
                }else{
                  nameError=null;
                }
                setState(() {});
              },
              textAlign: TextAlign.center,
              helperText: 'Enter your full name'),
          const SizedBox(height: kDefaultHeight / 2),
          // Country Dropdown
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
                        _doctor.country = data;
                        setState(() {});
                      }
                    },
                    selectItems: _doctor.country,
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
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  errorText: cityError,
                  onChanged: (v) {
                    _doctor.city = v.trim();
                    if (v.isNotEmpty) {
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
          //Phone number
          CustomInputField(
            height: kDefaultHeight * 3.5,
            label: 'Phone Number',
            textAlign: TextAlign.start,
            cursorHeight: 15,
            keyboardType: TextInputType.number,
            errorText: phoneError,
            onChanged: (v) {
              _doctor.phoneNumber=v.trim();
              if (v.isNotEmpty) {
                phoneValidation();
              }else{
                phoneError=null;
              }
              setState(() {});
            },
            prefixText: (_doctor.country.isEmpty)
                ? null
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '+${countryData[_doctor.country]![0]}',
                      style: const TextStyle(
                          color: kInputTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            helperText:
                'Please Provide a valid Number Where users can contact you',
          ),
          const SizedBox(height: kDefaultHeight / 2),
          const FormHeading(text: 'Professional Info'),
          const SizedBox(height: kDefaultHeight / 2),
          //practice dropdown
          PracticeDropDown(
              items: PracticeData.practiceType,
              label: 'Practice Type',
              selectItems: _doctor.practiceType,
              onChanged: (v) {
                if (v!=null) {
                     if (_doctor.practiceType!=v){
                       _doctor.specialities.clear();
                       setState(() {
                       });
                     }
                  _doctor.practiceType = v;
                  setState(() {});
                }
              }),
          const SizedBox(height: kDefaultHeight / 2),
          Text('Please Select Your Practice Type',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 9,)),
          const SizedBox(height: kDefaultHeight / 2),
          if (_doctor.practiceType.isNotEmpty)
            //specialities dropdown
            PracticeSubType(
                items: practiceSubTypes[_doctor.practiceType]!,
                label: 'Specialities',
                selectItems: selectSubType,
                onChanged: (v) {
                  if (v != null && ! _doctor.specialities.contains(v)) {
                    _doctor.specialities.add(v);
                    setState(() {});
                  }
                }),
          const SizedBox(
            height: kDefaultHeight / 2,
          ),
          if (_doctor.specialities.isNotEmpty)
            // chips selection
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      direction: Axis.horizontal,
                      children: _doctor.specialities
                          .map((e) => SelectionChip(
                              label: e,
                              onTap: () {
                                _doctor.specialities.remove(e);
                                setState(() {});
                              }))
                          .toList()),
                  const SizedBox(
                    height: kDefaultHeight,
                  )
                ],
              ),
            ),
          const SizedBox(
            height: kDefaultHeight / 3,
          ),
          //work experience field
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  experienceError ?? 'Enter your work experience in years',
                  style: TextStyle(
                      color: experienceError == null ? kPrimaryColor : kErrorColor,
                      fontSize: 11),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: (orientation == Orientation.portrait) ? 100 : 200,
                child: CustomInputField(
                  height: kDefaultHeight * 3,
                  label: 'Experience',
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    _doctor.experience=v.trim();
                    if (v.isNotEmpty) {
                      experienceValidation();
                    }else{
                      experienceError=null;
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kDefaultHeight / 3,
          ),
          //appointment field
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                appointmentError ?? 'Appointment Fee',
                style: TextStyle(
                    color: appointmentError == null
                        ? kPrimaryColor
                        : kErrorColor,
                    fontSize: 11),
              ),
              const Spacer(),
              SizedBox(
                width: (orientation == Orientation.portrait)
                    ?140
                    :250,
                child: CustomInputField(
                  height: kDefaultHeight * 3,
                  label: 'Appointment Fee',
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  suffix: (_doctor.country.isEmpty)
                      ? null
                      : Text(
                          '${countryData[_doctor.country]![1][0]}',
                          style: TextStyle(
                              color: appointmentError == null
                                  ? kInputTextColor
                                  : kErrorColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                  onChanged: (v) {
                    _doctor.appointmentFee=v.trim();
                    if (v.isNotEmpty) {
                      appointmentValidation();
                    }else{
                      appointmentError=null;
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          //workplace name
          CustomInputField(
              height: kDefaultHeight * 3.5,
              textInputAction: TextInputAction.next,
              errorText: workPlaceNameError,
              onChanged: (v) {
                _doctor.workplaceName=v.trim();
                if(v.isNotEmpty){
                  workPlaceNameValidation();
                }else{
                  workPlaceNameError=null;
                }
                setState(() {
                });
              },
              label: 'WorkPlace Name',
              textAlign: TextAlign.start,
              helperText:'Enter the name of your Workplace(e.g Hospital/Clinic)'),
          const SizedBox(
            height: kDefaultHeight / 2,
          ),
          //workplace address
          CustomInputField(
              height: kDefaultHeight * 3.5,
              textInputAction: TextInputAction.next,
              errorText: workPlaceAddressError,
              onChanged: (v) {
                _doctor.workplaceAddress =v.trim();
                if (v.isNotEmpty) {
                  workPlaceAddressValidation();
                }else{
                  workPlaceAddressError=null;
                }
                setState(() {
                });
              },
              label: 'WorkPlace Address',
              textAlign: TextAlign.start,
              helperText: 'Enter the address of your workplace'),
          const SizedBox(height: kDefaultHeight / 2),
          Obx(()=>(
               roleController.selectImage.isEmpty
              || _doctor.name.isEmpty
              || _doctor.country.isEmpty
              || _doctor.city.isEmpty
              || _doctor.phoneNumber.isEmpty
              || _doctor.practiceType.isEmpty
              || _doctor.specialities.isEmpty
              || _doctor.experience.isEmpty
              || _doctor.appointmentFee.isEmpty
              || _doctor.workplaceName.isEmpty
              || _doctor.workplaceAddress.isEmpty
          )
                      ?const SizedBox()
                      :Column(
            children: [
              const SizedBox(height: kDefaultHeight / 2),
              const Divider(
                color: kTextColor,
              ),
              const SizedBox(height: kDefaultHeight / 2),
             isLoading?const CustomCircleProgressIndicator():ButtonWithIcon(
                width: 100,
                height: 30,
                defaultLinearGradient: true,
                textSize: 15,
                text: 'Next',
                icon: Icons.arrow_forward,
                iconSize: 25,
                onPressed: () async{
                  setState(() {
                    isLoading=true;
                  });
                  fieldsValidation();
                  if (_canProceed) {
                    await roleController.doctorForm(doctor: _doctor);
                  }
                  setState(() {
                    isLoading=false;
                  });
                },
              )
            ],
          )

          )
        ],
      ),
    );
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
    return SizedBox(
      height: 50,
      child: CustomDropDown(
        items: items,
        labelText: label,
        showSearchBox: false,
        mode: Mode.MENU,
        maxHeight: 100,
        contentPadding: const EdgeInsets.only(left: 20, top: 10),
        popupItemBuilder: (context,v, isBool) => Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text((v == null) ? label : v.toString(),
                  style: const TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: onChanged,
        dropdownBuilder: (selectItems == null || selectItems!.isEmpty)
            ? null
            : (context, s, v) {
                return Text(v,
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
    return SizedBox(
      height: 50,
      child: CustomDropDown(
        items: items,
        labelText: label,
        showSearchBox: false,
        mode: Mode.MENU,
        maxHeight: 150,
        contentPadding: const EdgeInsets.only(left: 20, top: 10),
        popupItemBuilder: (context, v, isBool) => Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(v.toString(), style: const TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: onChanged,
        dropdownBuilder: (context, v, isBool) =>Text('Specialities',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kInputTextColor),
            textAlign: TextAlign.center),
      ),
    );
  }
}
