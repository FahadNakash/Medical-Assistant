import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../models/drug.dart';
import '../../../models/drug_interaction_model.dart';
import '../../../routes/app_pages.dart';
class DrugTile extends StatefulWidget{
  final String name;
  final String genericId;
  final String token;
  const DrugTile({Key? key,required this.name,this.genericId='',required this.token}) : super(key: key);

  @override
  State<DrugTile> createState() => _DrugTileState();
}

class _DrugTileState extends State<DrugTile>{
  final Dio _dio=Dio();
  bool _isloading=false;
  bool _isError=false;

  Future<void> _drugDetail()async{
    setState(() {
      _isloading=true;
    });
    try{
      final String _genericId=widget.genericId.split(':')[1];
      final _drugInfoUrl='$kBaseUrl/medicines/generics/$_genericId';
      final _drugInteractionUrl='$kBaseUrl/interactions/generics/$_genericId';

      final _drugInfoResponse=await _dio.get(_drugInfoUrl,options: Options(headers:{ 'Authorization':'Bearer ${widget.token}'},));
      final _drugInteractionResponse=await _dio.get(_drugInteractionUrl,options: Options(headers:{ 'Authorization':'Bearer ${widget.token}'},));

      if (_drugInfoResponse.statusCode==200 && _drugInteractionResponse.statusCode==200){
        final Drug _drugInfo=Drug.fromJson(_drugInfoResponse.data);
        final DrugInteraction _drugInteraction=DrugInteraction.fromJson(_drugInteractionResponse.data);
        _isloading=false;
        _isError=false;
        setState(() {});
        Get.toNamed(Routes.drug_detail,arguments: {
          'drug_info':_drugInfo.toJson(),
          'drug_interact':_drugInteraction.toJson()
        });
      }

    }on DioError catch(_){
      _isError=true;
      _isloading=false;
      setState(() {});
    }catch(_){
      _isError=true;
      _isloading=false;
      setState(() {});
    }

  }




  @override
  Widget build(BuildContext context){
    return  Theme(
      data: ThemeData(
        splashColor:Colors.white,
        highlightColor: Colors.white
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2,),
        shape:RoundedRectangleBorder(side: BorderSide(width: 1,color:_isError?kErrorColor:kPrimaryColor.withOpacity(0.1)),borderRadius: BorderRadius.circular(15)),
        title: Text(widget.name,style: TextStyle(color: kHeading1Color.withOpacity(0.8),fontSize: 12,fontFamily: 'Comfortaa')),
        subtitle: Text(widget.genericId,style: const TextStyle(color: Colors.black54,fontSize: 10,fontFamily: 'Comfortaa')),
        trailing:_isloading
            ?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:    const [
            SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color:kInputTextColor ,
                )),
            SizedBox(height: kDefaultHeight/3),
            Text('Fetching Data',style: TextStyle(color: Colors.black54,fontSize: 8,fontFamily: 'Comfortaa'))
          ],
        )
            :SizedBox(child: Icon(_isError?Icons.replay:Icons.download,color: _isError?kErrorColor:kHeading1Color.withOpacity(0.5),)),
        onTap: ()async{
          await _drugDetail();

        },
      ),
    );
  }
}
