 // ignore_for_file: constant_identifier_names
 part of 'app_pages.dart';
abstract class Routes{
  Routes._();
  static const splash=_Paths.splash;
  static const onboarding=_Paths.onboarding;
  static const auth=_Paths.auth;
  static const role=_Paths.role;
  static const home=_Paths.home;
  static const chat=_Paths.chat;
  static const main_home=_Paths.drawer_home;
  static const user_profile=_Paths.user_profile;
  static const search_specialist=_Paths.search_specialist;
  static const message_list=_Paths.message_list;
  static const pharmacies=_Paths.pharmacies;
  static const my_contacts=_Paths.my_contacts;
  static const search_drug=_Paths.search_drug;
  static const drug_detail=_Paths.drug_detail;
  static const search_disease=_Paths.search_disease;
  static const disease_detail=_Paths.disease_detail;
}
abstract class _Paths{
  static const splash='/splash';
  static const onboarding='/onboarding';
  static const auth='/auth';
  static const role='/role';
  static const home='/home';
  static const chat='/chat';
  static const drawer_home='/drawer_home';
  static const user_profile='/user_profile';
  static const search_specialist='/search_specialist';
  static const message_list='/message_list';
  static const pharmacies='/pharmacies';
  static const my_contacts='/my_contacts';
  static const search_drug='/search_drug';
  static const drug_detail='/drug_detail';
  static const search_disease='/search_disease';
  static const disease_detail='/disease_detail';



}