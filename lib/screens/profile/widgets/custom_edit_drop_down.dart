import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';

class CustomEditDropDown<T> extends StatelessWidget {
  final String title;
  final bool showSearchBox;
  final Mode mode;
  final List<T>? items;
  final T? selectItem;
  final double maxHeight;
  final Function(T?)? onChanged;
  final DropdownSearchPopupItemBuilder<T>? popUpItemBuilder;
  final DropdownSearchBuilder<T>? dropdownSearchBuilder;
  const CustomEditDropDown(
      {Key? key,
      required this.title,
      required this.showSearchBox,
      required this.mode,
      required this.maxHeight,
      this.items,
      this.selectItem,
      this.popUpItemBuilder,
      this.dropdownSearchBuilder,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding * 2),
      height: kDefaultHeight + 30,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
                width: kDefaultWidth * 6,
                child: Text('$title:',
                    style: const TextStyle(
                        fontSize: 13,
                        color: kblue,
                        fontWeight: FontWeight.w500))),
          ),
          Expanded(
            flex: 3,
            child: DropdownSelection<T>(
              mode: mode,
              maxHeight: maxHeight,
              items: items,
              showAsSuffixIcons: false,
              dropDownButton: const Icon(Icons.arrow_drop_down,color: kInputTextColor,size: 30),
              searchFieldProps: TextFieldProps(
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                      label: const Text(
                        'Search Country',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: kInputTextColor),
                      ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: kInputTextColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                  )
              ),
              showSearchBox: showSearchBox,
              dropdownSearchDecoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGrey, width: 0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kInputTextColor, width: 0)),
                labelStyle: TextStyle(color: kInputTextColor, fontSize: 15,leadingDistribution: TextLeadingDistribution.even),
                contentPadding: EdgeInsets.only(left: 0),
              ),
              searchBoxDecoration: const InputDecoration(
                  labelText: 'Country',
                  filled: true,
                  labelStyle: TextStyle(color: kInputTextColor),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kInputTextColor),
                      borderRadius: BorderRadius.all(Radius.circular(70))),
                  fillColor: kCream,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: kInputTextColor)),
                  border: OutlineInputBorder()),
              selectedItem: selectItem,
              showSelectedItem: true,
              onChanged: onChanged,
              enabled: true,
              popupBackgroundColor: kCream,
              popupItemBuilder: popUpItemBuilder,
              popupShape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  )),

              dropdownBuilder: dropdownSearchBuilder,
            ),
          )
        ],
      ),
    );
  }
}

// class CustomEditDropDown<T> extends StatelessWidget {
//   final List<T> items;
//   final T? selectItems;
//   final EdgeInsets? contentPadding;
//   final DropdownSearchBuilder<T?>? dropdownBuilder;
//   final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;
//   final void Function(T?)? onChanged;
//   const CustomEditDropDown(
//       {Key? key,
//         required this.items,
//         this.selectItems,
//         this.dropdownBuilder,
//         this.popupItemBuilder,
//         this.onChanged})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context){
//     return
//
//   DropdownSelection<T>(
//
//           filled: true,
//           fillColor: kInputBgColor,
//         ),
//         maxHeight:maxHeight,
//         enabled: true,
//         //searchFieldProps: TextFieldProps(style:TextStyle(color: kPrimaryColor)),
//         //showClearButton: true,
//         //clearButton: Icon(Icons.clear,color: kErrorColor),
//         dropDownButton: Icon(Icons.arrow_drop_down, color: kPrimaryColor),
//         showSelectedItem: true,
//         popupBackgroundColor: kInputBgColor,
//         popupBarrierColor: Colors.black.withOpacity(0.5),
//         popupShape:OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             borderSide: BorderSide(color: kInputTextColor,width: 2)
//         ),
//         popupItemBuilder: popupItemBuilder,
//         showSearchBox: showSearchBox,
//         items: items,
//         // searchFieldProps: TextFieldProps(cursorColor: kInputTextColor,style: TextStyle(color: Colors.red)),
//         searchBoxStyle: TextStyle(color: kPrimaryColor),
//         searchBoxDecoration:
//         onChanged: onChanged,
//         dropdownBuilder: dropdownBuilder,
//       ),
//     );
//   }
// }
