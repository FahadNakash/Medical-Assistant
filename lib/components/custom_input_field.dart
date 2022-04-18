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
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? initialValue;      //suffixIcon
  final String? helperText;
  final String? errorText;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final double? fieldwidth;
  final List<TextInputFormatter>? inputFormatters;
  final String? counterText;
  final Widget? prefixText;
  final TextAlign textAlign;
  final double cursorWidth;
  final double cursorHeight;
  final double? height;
  final double? width;
  final double? inputTextSize;
  final String? suffixText;
  final Widget? suffixIcon;
  CustomInputField(
      {Key? key,
      required this.label,
        this.suffixIcon,
        this.inputTextSize=15,
         this.height,
         this.width,
        this.cursorWidth=1,
        this.cursorHeight=15,
      this.controller,
      this.fieldwidth,
      this.onChanged,
      this.onSaved,
      this.onFieldSubmitted,
        this.onEditingComplete,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.obscureText = false,
      this.initialValue,
      this.helperText = '',
      this.errorText,
      this.hintText,
      this.suffix,
        this.suffixText,
        this.prefixIcon,
        required this.textAlign,
      this.focusNode,
      this.inputFormatters,
      this.counterText,
        this.prefixText
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
       height: height,
      width:width,
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: kHeading2Color.withOpacity(0.6),
                spreadRadius: -20,
                offset: Offset(0, 5),
                blurRadius: 5),
            //BoxShadow(color: Colors.white,spreadRadius: 3,offset: Offset(290,5)),
          ]),
      child: TextFormField(
        toolbarOptions: ToolbarOptions(selectAll: true,copy: true,cut: true,),
        strutStyle: StrutStyle(),
        textAlign: textAlign,
        maxLines: 1,
        style: TextStyle(color: (errorText == null) ? kInputTextColor: Theme.of(context).errorColor,fontFamily: 'Comfortaa',fontSize: inputTextSize),
        showCursor: true,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorColor: (errorText == null) ? kInputTextColor : kErrorColor,
        autocorrect: true,
        enableSuggestions: true,
        decoration: InputDecoration(
            counterText: counterText,
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: kInputTextColor)),
            focusColor: Theme.of(context).focusColor,
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide: BorderSide(color: Theme.of(context).errorColor)),
            //border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Colors.yellow)),
            enabled: true,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide:BorderSide(color: kHeading1Color.withOpacity(0.2))),
            filled: true,
            fillColor:(errorText == null) ? kInputBgColor : Color(0xffFDF7F6),
            errorStyle: TextStyle(fontFamily: 'Comfortaa', fontSize: 10,),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide: BorderSide(color: kErrorColor)),
            hintStyle:TextStyle(color: Theme.of(context).hintColor, fontFamily: 'Comfortaa'),
            label: Text(label,style: TextStyle(color:kPrimaryColor,fontFamily: 'Comfortaa',fontSize: 13),
            ),
            helperText: helperText,
            helperStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 9),
            errorText: errorText,
            hintText: hintText,
            suffix: suffix,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefix: prefixText,
          contentPadding: EdgeInsets.all(5)
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
        onEditingComplete:onEditingComplete,
        initialValue: initialValue,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
      ),
    );
  }
}

