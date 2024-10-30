import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  final String email;
  final String password;
  final String userType;
  const UserModel({required this.email,required this.userType,required this.password});

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "userType": userType,
  };
}