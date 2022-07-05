import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../controllers/app_controller.dart';
class Utils{

  final appController=AppController.appGetter;
  //check current greetings
  String checkGreeting(){
    final time=DateTime.now().hour;
    if (time<12 ) {
      return 'Good Morning';
    }else if ( (time>=12) && (time<=16)) {
      return 'Good Afternoon';
    }else if((time>16) && (time<20)){
      return 'Good Evening';
    }else{
      return 'Good Night';
    }
  }

  Future<String?> createOrFindFolder()async{
    try {
      final Directory _appDir=await getApplicationDocumentsDirectory();
      final folderName=_appDir.path+'/images/';
      final Directory _appDirFolder=Directory(folderName);
      if ((await _appDirFolder.exists())){
         return _appDirFolder.path;
       }else{
         final Directory _appNewDirFolder=await _appDirFolder.create(recursive: true);
         return _appNewDirFolder.path;
       }
    }catch(e){
      if (kDebugMode) {
        print('error is $e');
      }
    }
    return null;
  }

  String getNameFromUrl(String url){
    final firstSplit=url.split('%2F').last;
    final secondSplit=firstSplit.split('?').first;
    return secondSplit;
  }

  Future<void> storeImageLocally({required String url,required String imageName})async{
  try{
    final response = await http.get(Uri.parse(url));
    final _folderPath=await createOrFindFolder();
    if (_folderPath!=null){
      File file=File(_folderPath+ imageName);
      final _raf=file.openSync(mode: FileMode.write);
      _raf.writeFromSync(response.bodyBytes);
      await _raf.close();
    }
  }on FileSystemException catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
  catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
  }

  Future<String?> getImageLocally(String uid)async{
    final _checkFolder=await createOrFindFolder();
    if (_checkFolder!=null) {
      final _filePath=_checkFolder+'$uid.jpg';
      final file=File(_filePath);
      if (await file.exists()){
        return file.path;
      }
    }
    return null;
  }

  Future<File?> getImageFileLocally(String uid)async{
    final _checkFolder=await createOrFindFolder();
    if (_checkFolder!=null) {
      final _filePath=_checkFolder+'$uid.jpg';
      final file=File(_filePath);
      if (await file.exists()){
        imageCache!.clear();
        return file;
      }
    }
    return null;
  }

}