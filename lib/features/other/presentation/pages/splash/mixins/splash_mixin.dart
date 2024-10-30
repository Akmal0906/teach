
part of "../splash_page.dart";

mixin SplashMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();
    nextToNavigation();
  }

  Future<void> nextToNavigation() async {

   await Future.delayed(const Duration(seconds: 2));
   print('working');
    if (!localSource.hasProfile) {
      context.goNamed(Routes.auth);
    } else {
      context.goNamed(Routes.explore);
    }
    return;
  }


}
