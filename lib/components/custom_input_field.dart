import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant.dart';
import 'package:patient_assistant/constant.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? initialValue;
  final String? helperText;
  final String? errorText;
  final String? hintText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? counterText;
  CustomInputField(
      {Key? key,
      required this.label,
      this.controller,
      this.onChanged,
      this.onSaved,
      this.onFieldSubmitted,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.obscureText = false,
      this.initialValue,
      this.helperText = '',
      this.errorText,
      this.hintText,
      this.suffixIcon,
      this.focusNode,
      this.inputFormatters,
      this.counterText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Stack(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: kHeadingColor.withOpacity(0.6),
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                      blurRadius: 5),
                  //BoxShadow(color: Colors.white,spreadRadius: 3,offset: Offset(290,5)),
                ]),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            style: TextStyle(color: (errorText == null) ? kPrimaryColor : kErrorColor),
            showCursor: true,
            cursorColor: (errorText == null) ? kPrimaryColor : kErrorColor,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
                counterText: counterText,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: kHeading2Color)),
                focusColor: kHeading2Color,
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide: BorderSide(color: kErrorColor)),
                //border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Colors.yellow)),
                enabled: true,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide:BorderSide(color: kHeading2Color.withOpacity(0.2))),
                filled: true,
                fillColor:(errorText == null) ? kInputFieldColor : Color(0xffFDF7F6),
                errorStyle: TextStyle(fontFamily: 'Comfortaa', fontSize: 10,),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide: BorderSide(color: kErrorColor)),
                hintStyle:TextStyle(color: kHeading2Color, fontFamily: 'Comfortaa'),
                label: Text(label,style: TextStyle(color: kPrimaryColor,fontFamily: 'Comfortaa',fontSize: 13),
                ),
                helperText: helperText,
                helperStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10),
                errorText: errorText,
                hintText: hintText,
                suffix: suffixIcon,
                // suffixIconColor:(errorText == null) ? kPrimaryColor : kErrorColor
            ),
            controller: controller,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            onFieldSubmitted: onFieldSubmitted,
            initialValue: initialValue,
            focusNode: focusNode,
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }
}
