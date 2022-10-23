import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../components/search_field.dart';
import '../../constant.dart';
import '../../credentials.dart';

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
  String _errorCode='';
  String _errorMsg='';
  List<Map<String,dynamic>>? _drugData;

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
      await _requestData(v);
    });
  }

  Future<String> _getToken()async{
    const String url='https://healthos.co/api/v1/oauth/token.json';
    // Todo change auth credentials
    final response=await Dio().post(url, data:healthOsCredentialsB,options: Options(
        method: 'POST',
        validateStatus: (_)=>true
    ));
    if (response.statusCode==200){
      _authToken=response.data['access_token'];
    }
    return _authToken;
  }

  Future<void> _requestData(String v)async{
    try{
      final _token=_authToken.isEmpty?await _getToken():_authToken;
      final url='$kBaseUrl/search/medicines/generics/$v';
      final response=await _dio.get(url,options: Options(headers: { 'Authorization':'Bearer $_token' },));
      if (response.statusCode==200) {
        _drugData=List<Map<String,dynamic>>.from(response.data);
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          _isError=false;
          _isLoading=false;
        });
      }
      _isError=false;
      _isLoading=false;
      setState(() {});
    }on DioError catch (e){
      _errorCode=e.response!.statusCode.toString();
      _errorMsg=e.response!.data['error_message'];
      _isError=true;
      _isLoading=false;
      setState(() {});
    }catch(_){

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
                    title: 'Drugs Info',
                    hintText: 'Try \'Acarbose\' or \'Paracetamol\' ',
                    isLoading: _isLoading,
                    onChanged: (v){
                      if (v.isNotEmpty){
                        _isLoading=true;
                        setState(() {});
                        _setTime(v.trim());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
