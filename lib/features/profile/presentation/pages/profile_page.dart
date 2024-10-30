import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teach/service/auth_service.dart';

import '../../../../core/widgets/custom_cached_network_image.dart';
import '../../../../router/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 21),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCachedNetworkImage(
                imageUrl:
                // profileModel!.results.image,
                //??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnGWEwXpRS7z7rVaGrjIWWTdE8_TiYTGiYjA&s",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                    Border.all(width: 3, color: Colors.white),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 28,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('email ${localSource.email}'),
                  SizedBox(height:8,),
                  Text('password ${localSource.password}'),
                  SizedBox(height:8,),

                  Text('user Typeee ${localSource.type}'),
                ],
              ),


              SizedBox(height: 24,),
              TextButton(
                  onPressed: () async {
                    final auth = AuthService();
                    localSource.clear();
                    await auth.signOut();
                    context.goNamed(Routes.auth);
                  },
                  child: const Text('Log out')),
            ],
          ),
        ),
      ),
    );
  }
}
