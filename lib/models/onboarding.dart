class OnBoarding{
  final String? title;
  final String? descriptions;
  final String? imageUrl;

  OnBoarding({
    this.title,
    this.descriptions,
    this.imageUrl
  }
  );
}
final List<OnBoarding> onBoardingItems=[
  OnBoarding(title:'Find Specialists',    imageUrl: 'assets/images/1findspeciallist.svg',descriptions: 'Search for Specialist and get recommendations based on your Medical Conditions.' ),
  OnBoarding(title:'Get In Touch',        imageUrl: 'assets/images/2getintouch.svg',descriptions: 'Message your Doctor to schedule an Appointment beforehand.' ),
  OnBoarding(title:'Stay Notified',       imageUrl: 'assets/images/3staynotified.svg',descriptions: 'Keep track of your Medication and Appointments easily and get notified on time.' ),
  OnBoarding(title:'Cloud Sync',          imageUrl: 'assets/images/4cloudsync.svg',descriptions: 'Sync and save all your data in Cloud Storage to use on other devices.' ),
  OnBoarding(title:'Location & Direction',imageUrl: 'assets/images/5location.svg',descriptions: 'Find nearby Pharmacies and Directions for Hospitals and Clinics.' ),
  OnBoarding(title:'Drug Info',           imageUrl: 'assets/images/6druginfo.svg',descriptions: 'Search Drugs for their uses,side effects and their interaction with other drugs.' ),
  OnBoarding(title:'All Right',           imageUrl: 'assets/images/7allright.svg',descriptions: 'Everything is set.Lets get started now.' ),
];