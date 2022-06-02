import 'dart:io';
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

  Future<String?> createFolderLocally()async{
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
      print('error is $e');
    }
    return null;
  }

  String getNameFromUrl(String url){
    final firstSplit=url.split('%2F').last;
    final secondSplit=firstSplit.split('?').first;
    return secondSplit;
  }

  Future<void> storeImageLocally(String url)async{
  try{
    final response = await http.get(Uri.parse(url));
    final folderPath=await createFolderLocally();
    if (folderPath!=null){
      final filename=getNameFromUrl(url);
      File file=File(folderPath+ filename);
      final raf=file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.bodyBytes);
      await raf.close();
    }
  }catch(e){
    print(e);
  }
  }

  Future<String?> getImageLocally()async{
    final checkFolder=await createFolderLocally();
    if (checkFolder!=null) {
      final folderPath=checkFolder+'${appController.user.uid}.jpg';
      final file=File(folderPath);
      print(file.path);
      if (await file.exists()){
        return file.path;
      }
    }
    return null;
  }

}