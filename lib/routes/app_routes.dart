 part of 'app_pages.dart';
abstract class Routes{
  Routes._();
  static const splash=_Paths.splash;
  static const onboarding=_Paths.onboarding;
  static const auth=_Paths.auth;
  static const role=_Paths.role;
  static const home=_Paths.home;
  static const main_home=_Paths.drawer_home;
  static const user_profile=_Paths.user_profile;
}
abstract class _Paths{
  static const splash='/splash';
  static const onboarding='/onboarding';
  static const auth='/auth';
  static const role='/role';
  static const home='/home';
  static const drawer_home='/drawer_home';
  static const user_profile='/user_profile';


}