import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:teach/core/bottom_sheet/bottom_sheet_widget.dart';
import 'package:teach/features/auth/data/model/user_model.dart';
import 'package:teach/router/app_routes.dart';

import '../constants/image_constants.dart';
import '../core/custom_snackbar/custom_snack_bar.dart';
import '../core/custom_snackbar/top_snack_bar.dart';
import '../features/profile/presentation/model/task_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailPassword(UserModel userModel) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      return user.user;
    } catch (e) {
      print('catch signIn workinggggg');
    }
    return null;
  }

  Future<void> route(BuildContext context, UserModel userModel) async {
    User? user = FirebaseAuth.instance.currentUser;
    //final snapshot = await FirebaseFirestore.instance.collection(userModel.userType).get();
    CollectionReference users =
        FirebaseFirestore.instance.collection(userModel.userType);

    users.add(userModel.toJson()).then((value) {
      print('added user');
      localSource.setHasProfile(value: true);
      localSource.setEmail(userModel.email);
      localSource.setPassword(userModel.password);
      localSource.setType(userModel.userType);
      context.goNamed(Routes.explore);
    }).catchError((error) => print("error occured $error"));

    print('collection bush emas');
  }

  Future<User?> loginUserWithEmailPassword(UserModel userModel) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      return user.user;
    } catch (e) {
      print('catch login workinggggg');
    }
    return null;
  }

  Future<void> checkUserType(UserModel userModel, BuildContext context) async {
    try {
      final db = await FirebaseFirestore.instance;
      db
          .collection(userModel.userType)
          .where("email", isEqualTo: userModel.email)
          .get()
          .then(
        (querySnapshot) {
          print('dataaaaaaaaa ${querySnapshot.docs.length}');
          if (querySnapshot.docs.isNotEmpty) {
            localSource.setType(userModel.userType);
            localSource.setPassword(userModel.password);
            localSource.setHasProfile(value: true);
            localSource.setEmail(userModel.email);
            context.goNamed(Routes.explore);
          } else {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                icon: SvgPicture.asset(SvgIcons.icWarning, color: Colors.red),
                message: "Fill them all correct",
              ),
            );
          }
        },
        onError: (e) {
          print("Error completing: $e");
        },
      );
    } catch (e) {
      print('catch login workinggggg');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('catch logout workinggggg');
    }
  }


  Future<void> createSubCollection(String world)async{
   // final bool isTure=await checkIfCollectionExist(localSource.type??"",'news');
    if(true) {
      final db = FirebaseFirestore.instance;
      await db.collection(localSource.type ?? '').doc().collection('news').add({
        'world': world
      }).then((value) {
        print('added sub class');
      });
    }else{
      var collection = FirebaseFirestore.instance.collection(localSource.type??"").doc().collection('news');
      collection
          .add({"world":"salomlar"}) // <-- Your data
          .then((_) => print('salom qushildi Added'))
          .catchError((error) => print('Add failed: $error'));
    }
  }

  Future<void> addData(TaskModel taskModel)async{
    final db=FirebaseFirestore.instance;
    db.collection(localSource.type??"").add(taskModel.toJson());

  }

  Future<void> uploadFile(File file,String path,TaskModel taskModel)async{
    final ref=FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    await addData(taskModel);
  }

  Future<String> getAllDataWithCollection()async{

     String path='';


       final  storageRef = FirebaseStorage.instance.ref().child('Fizika/');
       storageRef.listAll().then((result) {
         result.items.forEach((Reference ref) {
           path=ref.fullPath;
           print('Found file: ${ref.fullPath}');
         });
       });



    return path;
  }

  Future<void> getPathStorage() async {
    print('wotkinggggg');
    final result =
    await FirebaseStorage.instance.ref('/Fizika').listAll();

    result.items.forEach((Reference ref) {
      print('Found file: ${ref.fullPath}');
    });

    result.prefixes.forEach((Reference ref) {
      print('Found directory: ${ref.fullPath}');
    });
  }
  Future<void> checkIfCollectionExist(String collectionName, String subCollectionName) async {
   final _db=FirebaseFirestore.instance;
    var value = await _db
        .collection(collectionName)
        .doc()
        .collection(subCollectionName)
        .get();
    print('value data ${value.docs.length}');
   // return value.docs.isEmpty;
  }
  Future<void> getData() async {
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection(localSource.type);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(final item in allData){
      final data=item as Map<String,dynamic>;
      print('dataaa lengthth ${data.length}');
    }
    print(allData);
  }

  Future<void> deleteDocument(String id,String filePath)async{
    print('dellllllllllll $filePath');
    print('dellllllll $id');
    FirebaseFirestore.instance.collection(localSource.type)
        .doc(id)
        .delete();
   await  FirebaseStorage.instance.ref(filePath).delete();
  }

}



