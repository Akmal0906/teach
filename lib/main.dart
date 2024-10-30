import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teach/router/app_routes.dart';
import 'injector_container.dart' as di;
void main() async{

 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
// WidgetsBinding.instance.addPostFrameCallback((_) async{
  await di.init();

 //});



  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
