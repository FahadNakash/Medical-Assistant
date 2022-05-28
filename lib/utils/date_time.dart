class Utils{
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
}