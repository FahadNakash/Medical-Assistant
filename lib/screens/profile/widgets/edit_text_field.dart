import 'package:flutter/material.dart';

import '../../../constant.dart';

// ignore: must_be_immutable
class EditTextField extends StatefulWidget {
  final String title;
  final String? initialValue;
  final String? prefixText;
  final String? suffixText;
  final Function(String)? onChanged;
  final String? errorText;
  bool isExpandField;
  TextInputType? keyboardType;
   EditTextField(
      {
        this.initialValue,
      required this.title,
      this.prefixText,
      this.suffixText,
      this.onChanged,
      this.errorText,
       this.keyboardType,
      this.isExpandField=true,
      Key? key})
      : super(key: key);
  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  bool _readOnly = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
                width: kDefaultWidth * 6,
                child: Text('${widget.title}:',
                    style: TextStyle(
                        fontSize: 13,
                        color: widget.errorText == null
                            ? kHeading2Color
                            : kErrorColor,
                        fontWeight: FontWeight.w500))),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
                height: 45,
                child: TextFormField(
                  focusNode: _focusNode,
                  readOnly: _readOnly,
                  initialValue: widget.initialValue,
                  keyboardType: widget.keyboardType,
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  cursorColor: kHeading1Color,
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(widget.prefixText ?? ''),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                          widget.suffixText ?? '',
                          style:const TextStyle(color: kInputTextColor)),
                    ),
                    prefixStyle:const TextStyle(
                        color:  kInputTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    contentPadding: const EdgeInsets.only(bottom: 15),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kTextColor, width: 0)),
                    focusedBorder: (_readOnly)
                        ? const UnderlineInputBorder(
                            borderSide: BorderSide(
                            color: kTextColor,
                          ))
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.errorText == null
                                    ? kHeading1Color
                                    : kErrorColor)),
                    fillColor: kHeading2Color,
                  ),
                  onChanged: widget.onChanged,
                )),
          ),
          GestureDetector(
              onTap: () {
                _focusNode.requestFocus();
                _readOnly = false;
                setState(() {});
              },
              child: Icon(
                Icons.edit,
                color: widget.errorText == null ? kHeading2Color : kErrorColor,
              ))
        ],
      ),
    );
  }
}
