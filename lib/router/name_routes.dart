part of "app_routes.dart";

sealed class Routes { Routes._();

  static const String initial = "/";

  /// Auth
  static const String auth = "/auth";
  static const String login = "/login";
  static const String register = "/register";
  static const String explore = "/explore";
  static const String story = "/story";

  static const String onboarding = "/onboarding";

  /// Profile
  static const String profile = "/profile";


  /// internet connection
  static const String noInternet = "/no-internet";


///Home page
static const String addTask= "/addTask";
}
