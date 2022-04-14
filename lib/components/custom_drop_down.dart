import 'package:flutter/material.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:patient_assistant/constant.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectItems;
  final String labelText;
  final bool showSearchBox;
  final double? maxHeight;
  final double? height;
  final double? width;
  final EdgeInsets? contentPadding;
  final Mode mode;
  final DropdownSearchBuilder<T?>? dropdownBuilder;
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;
  final void Function(T?)? onChanged;
  const CustomDropDown(
      {Key? key,
      required this.items,
      required this.labelText,
      required this.showSearchBox,
        required this.mode,
        this.contentPadding,
        this.maxHeight,
        this.height,
        this.width,
        this.selectItems,
      this.dropdownBuilder,
      this.popupItemBuilder,
      this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      height: height,
      width: width,
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: kHeading2Color.withOpacity(0.6),
                spreadRadius: -4,
                offset: Offset(-0, 6),
                blurRadius: 5
            ),
            //BoxShadow(color: Colors.white,spreadRadius: 3,offset: Offset(290,5)),
          ]),
      child: DropdownSelection<T>(
         mode: mode,
         dialogMaxWidth: width,
         label: labelText,
         dropdownSearchDecoration: InputDecoration(
          //hintText: 'hello',
          //helperText: 'hello',
          contentPadding: contentPadding,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: kHeading1Color.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: kInputTextColor,width: 1)),
          labelText: labelText,
          labelStyle:TextStyle(
            color: kPrimaryColor,
          ),
          filled: true,
          fillColor: kInputBgColor,
        ),
        maxHeight:maxHeight,
        enabled: true,
        //searchFieldProps: TextFieldProps(style:TextStyle(color: kPrimaryColor)),
        //showClearButton: true,
        //clearButton: Icon(Icons.clear,color: kErrorColor),
        dropDownButton: Icon(Icons.arrow_drop_down, color: kPrimaryColor),
        showSelectedItem: true,
        popupBackgroundColor: kInputBgColor,
        popupBarrierColor: Colors.black.withOpacity(0.5),
        popupShape:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: kInputTextColor,width: 2)
        ),
        popupItemBuilder: popupItemBuilder,
        showSearchBox: showSearchBox,
        items: items,
        // searchFieldProps: TextFieldProps(cursorColor: kInputTextColor,style: TextStyle(color: Colors.red)),
        searchBoxStyle: TextStyle(color: kPrimaryColor),
        searchBoxDecoration: InputDecoration(
            labelText: 'Country',
            labelStyle: TextStyle(color: kInputTextColor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kInputTextColor),
                borderRadius: BorderRadius.all(Radius.circular(70))),
            fillColor: kInputBgColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: kInputTextColor)),
            border: OutlineInputBorder()),
        onChanged: onChanged,
        dropdownBuilder: dropdownBuilder,
        showAsSuffixIcons: true,
        selectedItem: selectItems,
      ),
    );
  }
}
