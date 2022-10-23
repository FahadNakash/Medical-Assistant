import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
class SearchField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool error;
  final Function(String) onChanged;
  final bool isLoading;
  const SearchField({Key? key,required this.title,required this.hintText,required this.onChanged,this.isLoading=false,this.error=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(onTap: (){ Get.back();},child: const Icon(Icons.arrow_back_outlined,color: kblue)),
        const SizedBox(height: kDefaultHeight/2,),
        Text(title,style:  TextStyle(color: error?kErrorColor:kblue,fontFamily: 'Montserrat',fontWeight: FontWeight.w800),),
        const SizedBox(height: kDefaultHeight/2,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color:error? kErrorColor.withOpacity(0.7):kblue.withOpacity(0.2),offset: const Offset(0,0),blurRadius: 5),
              const BoxShadow(color: Colors.white,offset: Offset(0,0),blurRadius: 5),
            ]
          ),
          child: TextFormField(
            enabled: true,
            textAlign: TextAlign.start,
            showCursor: true,
            cursorColor:error?kErrorColor:kblue,
            cursorHeight: 22,
            cursorWidth: 1,
            style:  TextStyle(color:error?kErrorColor: kblue,fontSize: 20,fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),
            decoration:  InputDecoration(
              enabled: true,
                hintText: hintText,
                hintStyle:  TextStyle(fontSize: 15,color: error?kErrorColor.withOpacity(0.4):kblue.withOpacity(0.4),fontWeight: FontWeight.w600,fontFamily: 'Montserrat'),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(width: 2,color:error?kErrorColor:kblue.withOpacity(0.3))),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(width: 2,color: kblue.withOpacity(0.3))),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(width: 2,color: kblue.withOpacity(0.3))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:  BorderSide(color:error? kErrorColor:kblue,width: 2)),
              suffix:isLoading
                  ?SizedBox(
                  height: 23,
                  width: 23,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color:error?kErrorColor:kblue,
                  ))
                  :SizedBox(
                  height: 20,
                  width: 20,
                  child:Icon(Icons.search,color:error?kErrorColor:kblue,size: 23,)),
              suffixIconColor: Colors.red,
              suffixIconConstraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
              )
            ),
            onChanged: onChanged,

          ),
        ),

      ],
    );
  }
}

