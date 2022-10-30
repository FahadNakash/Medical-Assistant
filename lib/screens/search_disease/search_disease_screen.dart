import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../components/empty.dart';
import '../../components/search_field.dart';
import '../../constant.dart';
import '../../credentials.dart';
import '../../models/disease.dart';
import 'widgets/disease_tile.dart';

class SearchDiseaseScreen extends StatefulWidget {
  const SearchDiseaseScreen({Key? key}) : super(key: key);

  @override
  State<SearchDiseaseScreen> createState() => _SearchDiseaseScreenState();
}

class _SearchDiseaseScreenState extends State<SearchDiseaseScreen> {
  final Duration _duration=const Duration(milliseconds: 2000);
  final InternetConnectionChecker _networkStream=InternetConnectionChecker();
  late final StreamSubscription _streamSubscription;

  Timer? _timer;
  final Dio _dio=Dio();

  bool _isLoading=false;
  bool _isConnected=false;
  bool _isError=false;
  String _authToken='';
  String _errorCode='error code';
  String _errorMsg='error msg';
  List<Disease>? _diseaseList;

  void _streamChecker(){
    _streamSubscription=_networkStream.onStatusChange.listen((event) {
      if (InternetConnectionStatus.connected==event) {
        _isConnected=true;
        setState(() {});
      }else{
        _isConnected=false;
        setState(() {});
      }
    });
  }

  void _setTime(String v){
    if (_timer!=null) {
      _timer!.cancel();
      _timer=null;
    }
    _timer=Timer(_duration,()async{
      await _requestDiseaseData(v);
    });
  }

  Future<String> _getToken()async{
    const String url='https://healthos.co/api/v1/oauth/token.json';
    // Todo change auth credentials
    final response=await Dio().post(url, data:healthOsCredentialsA,options: Options(
        method: 'POST',
        validateStatus: (_)=>true
    ));
    if (response.statusCode==200){
      _authToken=response.data['access_token'];
    }
    return _authToken;
  }

  Future<void> _requestDiseaseData(String v)async{
    FocusManager.instance.primaryFocus?.unfocus();
    final List<Disease> _addDisease=[];
    try{
      final _token=_authToken.isEmpty?await _getToken():_authToken;
      final url='$kBaseUrl/search/diseases/$v';
      final response=await _dio.get(url,options: Options(headers: { 'Authorization':'Bearer $_token' },));
      if (response.statusCode==200) {
        final List<Map<String,dynamic>> _diseases=List<Map<String,dynamic>>.from(response.data);
        _diseaseList?.clear();
        for (var disease in _diseases){
          _addDisease.add(Disease.fromJson(disease));
        }
        _diseaseList=_addDisease;
      }
      _isError=false;
      _isLoading=false;
      setState(() {});
    }on DioError catch (e){
      _errorCode=e.response!.statusCode.toString();
      _errorMsg='${e.response!.statusMessage}';
      _diseaseList=null;
      _isError=true;
      _isLoading=false;
      setState(() {});
    }catch(e){
      _errorCode='404';
      _errorMsg='Something Wrong';
      _isError=true;
      _isLoading=false;
      _diseaseList=null;
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    _streamChecker();
  }
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _isPortrait=MediaQuery.of(context).orientation==Orientation.portrait;
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                children: [
                  const SizedBox(height: kDefaultHeight / 2),
                  SearchField(
                    error: _isError,
                    title: 'Disease Info',
                    hintText: 'Try \'Malaria\' or \'Neuronal diseases\' ',
                    isLoading: _isLoading,
                    onChanged: (v){
                      if (v.isNotEmpty){
                        _isLoading=true;
                        setState(() {});
                        _setTime(v.trim());
                      }
                    },
                  ),
                  const SizedBox(height: kDefaultHeight / 2),
                  Container(
                      constraints: BoxConstraints(
                          maxHeight:_isPortrait? 500:170
                      ),
                      child: _drawSearchResultTiles()
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
  Widget _drawSearchResultTiles(){
    return !_isConnected
        ?const Empty(middleText: kNoConErrMsg,icon: Icons.wifi_off,)
        :(_diseaseList==null)?Empty(error: _isError,middleText:_isError?'$_errorMsg.\nError code : $_errorCode':'Suggestion will be show here',image:_isError?'$kAssets/caution.svg':'$kAssets/coughing.svg',)
        :_diseaseList!.isEmpty?const Empty(middleText: 'No requested data has been found.',image: '$kAssets/empty_data.svg', )
        :ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context,index)=>const SizedBox(height: 10),
        itemCount: _diseaseList!.length,
        itemBuilder: (context,index){
          return DiseaseTile(
            disease: _diseaseList![index],
          );
        }
    )
    ;
  }
}
