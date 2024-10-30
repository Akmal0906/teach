import "dart:developer";
import "dart:io";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:dio/dio.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";
import "package:teach/core/either/either.dart";
import "package:teach/core/error/failure.dart";
import "package:teach/features/api/repository.dart";
import "package:teach/features/profile/presentation/model/task_model.dart";
import "package:teach/router/app_routes.dart";

import "../../core/error/server_error.dart";
import "../auth/data/login/login_user_request.dart";

class RepositoryImpl implements Repository {
  const RepositoryImpl({required this.dio});

  final Dio dio;

  // @override
  // Future<Either<Failure, String>> downloadPdf(String url) async {
  //   try {
  //     final Response<List<int>> response = await Dio().get<List<int>>(url,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           receiveTimeout: Duration.zero,
  //         ), onReceiveProgress: (t, t1) {
  //       print('downloading...');
  //       print((t / t1) * 100);
  //     });
  //
  //     final String path = await takeFilePath(url);
  //     await saveFile(response.data!, path);
  //     return Right(response.data.toString());
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<bool> saveFile(List<int> bytes, String path) async {
  //   print('Write 1 working $path');
  //   final File file = File(path);
  //   if (!file.existsSync()) {
  //     print('exist emas');
  //     file.writeAsBytesSync(
  //       bytes,
  //     );
  //
  //     return true;
  //   } else {
  //     print('exist');
  //
  //     final String newPath = await takeFilePath(path, addText: '(1)');
  //     return saveFile(bytes, newPath);
  //   }
  // }
  //
  // @override
  // Future<String> takeFilePath(String url, {String? addText = ''}) async {
  //   print("takePath working");
  //   Directory? directory;
  //   String newPath = '';
  //   directory = await getExternalStorageDirectory();
  //   print(directory?.path.toString());
  //   final List<String> folders = directory?.path.split("/") ?? [];
  //   final List<String> folders1 = url.split("/");
  //   final List<String> folder2 = folders1.last.split(".");
  //   final String lastPath = "${folder2.first}$addText.${folder2.last}";
  //
  //   for (int x = 1; x < folders.length; x++) {
  //     final String folder = folders[x];
  //     if (folder != 'Android') {
  //       newPath += '/$folder';
  //     } else {
  //       break;
  //     }
  //   }
  //
  //   return "$newPath/Download/$lastPath";
  // }
  //
  // @override
  // Future<Either<Failure, LoginUserResponse>> login(
  //     LoginUserRequest request) async {
  //   try {
  //     print('try workingnnnn');
  //     final Response response = await dio.post(
  //       Constants.baseUrl + Urls.loginUrl,
  //       data: request.toJson(),
  //     );
  //     print('Response dataaaaaaaaaa ${response.data}');
  //     return Right(LoginUserResponse.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, LessonsModel>> getLessons() async {
  //   try {
  //     final Response response = await dio.get(Constants.baseUrl + Urls.lessons,
  //         options: Options(headers: {
  //           "Authorization": "Bearer ${localSource.accessToken}",
  //         }));
  //     print('response data result ${response.data['results']}');
  //     return Right(LessonsModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, MyCourseModel>> getCourses() async {
  //   try {
  //     final Response response = await dio.get(Constants.baseUrl + Urls.courses,
  //         options: Options(headers: {
  //           "Authorization": "Bearer ${localSource.accessToken}",
  //         }));
  //
  //     return Right(MyCourseModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, CoursePlansModel>> getCoursePlans(
  //     {required String courseId}) async {
  //   try {
  //     final Response response = await dio.get(
  //         Constants.baseUrl + Urls.courses + courseId + Urls.coursePlan,
  //         options: Options(headers: {
  //           "Authorization": "Bearer ${localSource.accessToken}",
  //         }));
  //     print(response.realUri.toString());
  //     return Right(CoursePlansModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, AssignmentsModel>> getAssignments(
  //     {required String courseId}) async {
  //   final Map<String, dynamic> params = {"skip": 0, "limit": 10};
  //   try {
  //     final Response response =
  //         await dio.get(Constants.baseUrl + Urls.assignments + courseId,
  //             queryParameters: params,
  //             options: Options(headers: {
  //               "Authorization": "Bearer ${localSource.accessToken}",
  //             }));
  //     print(response.realUri.toString());
  //     return Right(AssignmentsModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, ProfileModel>> getProfileInfo() async {
  //   try {
  //     final Response response =
  //         await dio.get(Constants.baseUrl + Urls.profileInfo,
  //             options: Options(headers: {
  //               "Authorization": "Bearer ${localSource.accessToken}",
  //             }));
  //     print(response.realUri.toString());
  //     return Right(ProfileModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, String>> putProfileInfo(
  //     {required ProfileRequestModel profileRequestModel}) async {
  //   try {
  //     final Response response =
  //         await dio.put("${Constants.baseUrl}${Urls.profileInfo}/",
  //             data: profileRequestModel.toJson(),
  //             options: Options(headers: <String, dynamic>{
  //               "Content-Type": "application/json",
  //               "Authorization": "Bearer ${localSource.accessToken}",
  //             }));
  //     print(response.realUri.toString());
  //
  //     return const Right("Successfully updated");
  //   } on DioException catch (error, stacktrace) {
  //     print("RealUrl=>${error.response?.realUri.toString()}");
  //     print("Data=>${error.response?.data.toString()}");
  //     print("Extra=>${error.response?.extra.toString()}");
  //     print(
  //         "requestOptions=>${error.response?.requestOptions.data.toString()}");
  //
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, RegionsModel>> getRegionsModel(
  //     {required String endPointUrl}) async {
  //   try {
  //     final Response response =
  //         await dio.get("${Constants.baseUrl}$endPointUrl",
  //             options: Options(headers: <String, dynamic>{
  //               "Content-Type": "application/json",
  //               "Authorization": "Bearer ${localSource.accessToken}",
  //             }));
  //
  //     return Right(RegionsModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, List<Regions>>> getSchools() async {
  //   try {
  //     final Response response =
  //         await dio.get("${Constants.baseUrl}${Urls.schools}",
  //             options: Options(headers: <String, dynamic>{
  //               "Content-Type": "application/json",
  //               "Authorization": "Bearer ${localSource.accessToken}",
  //             }));
  //     final List<Regions> schools = (response.data as List)
  //         .map((userJson) => Regions.fromJson(userJson))
  //         .toList();
  //     return Right(schools);
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, FileModel>> postUploadFile({
  //   FormData? data,
  // }) async {
  //   try {
  //     print('data is Nulllllll $data');
  //     final Response response =
  //         await dio.post("${Constants.baseUrl}${Urls.uploadFile}",
  //             data: data,
  //             options: Options(headers: <String, dynamic>{
  //               "Content-Type": "multipart/form-data",
  //               "Authorization": "Bearer ${localSource.accessToken}",
  //             }), onReceiveProgress: (int sent, int total) {
  //       print("${(sent / total) * 100}%");
  //     });
  //
  //     return Right(FileModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, TestsModel>> getTests() async {
  //   try {
  //     final Response response = await dio.get(
  //       "${Constants.baseUrl}${Urls.tests}",
  //       options: Options(headers: <String, dynamic>{
  //         "Authorization": "Bearer ${localSource.accessToken}",
  //       }),
  //     );
  //
  //     return Right(TestsModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, TestQuestionModel>> postStartTest(
  //     {required String courseId}) async {
  //   try {
  //     final Response response = await dio.post(
  //       "${Constants.baseUrl}${Urls.startTest}$courseId",
  //       options: Options(headers: <String, dynamic>{
  //         "Authorization": "Bearer ${localSource.accessToken}",
  //       }),
  //     );
  //
  //     return Right(TestQuestionModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, String>> postSubmitTest(
  //     {required int testId,
  //     required int questionId,
  //     required int answerId}) async {
  //   final data = {
  //     "test_id": testId,
  //     "question_id": questionId,
  //     "answer_id": answerId
  //   };
  //   try {
  //     final Response response = await dio.post(
  //       "${Constants.baseUrl}${Urls.submit}",
  //       data: data,
  //       options: Options(headers: <String, dynamic>{
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer ${localSource.accessToken}",
  //       }),
  //     );
  //     return Right(response.data["message"]);
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, ResultTestModel>> postFinishTest(
  //     {required int testId}) async {
  //   try {
  //     final Response response = await dio.post(
  //       "${Constants.baseUrl}${Urls.finish}$testId/",
  //       options: Options(headers: <String, dynamic>{
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer ${localSource.accessToken}",
  //       }),
  //     );
  //
  //     return Right(ResultTestModel.fromJson(response.data));
  //   } on DioException catch (error, stacktrace) {
  //     log("Exception occurred: $error stacktrace: $stacktrace");
  //     return Left(ServerError.withDioError(error: error).failure);
  //   } on Exception catch (error, stacktrace) {
  //     log("Exception occurred $error stacktrace:$stacktrace");
  //     return Left(ServerError.withError(message: error.toString()).failure);
  //   }
  // }

  @override
  Future<Either<Failure, String>> register() async {
    try {
      final Response response = await dio.post(
        "",
        options: Options(headers: <String, dynamic>{
          "Content-Type": "application/json",
        }),
      );

      return Right(response.data);
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred $error stacktrace:$stacktrace");
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, String>> login(LoginUserRequest request) async {
    try {
      final Response response = await dio.post(
        "",
        options: Options(headers: <String, dynamic>{
          "Content-Type": "application/json",
        }),
      );

      return Right(response.data);
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred $error stacktrace:$stacktrace");
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getTasks() async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('Teacher');
      final storageRef = await FirebaseStorage.instance.ref().listAll();

      QuerySnapshot querySnapshot = await collectionRef.get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

      print(allData);
      final List<String> list =
          querySnapshot.docs.map((doc) => doc.reference.id).toList();
      print('listttttttttttttttt $list');
      List<Map<String, dynamic>> maps = [];
      for (int i = 0; i < allData.length; i++) {
        final data = allData[i] as Map<String, dynamic>;
        if (data.length > 3) {
          data['documentId'] = list[i];
          maps.add(data);
        }
      }
      return Right(maps);
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred $error stacktrace:$stacktrace");
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<List<String>?> getFilePath() async {
    try {
      final result = await FirebaseStorage.instance.ref('/Fizika').listAll();
      final List<String> pathList = [];
      result.items.forEach((Reference ref) {
        pathList.add(ref.fullPath);
      });
      print('pathhhhhhhhh listtttt ${pathList}');
      return pathList;
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
    }
    return null;
  }

  @override
  Future<Either<Failure, String>> deleteTasks(
      String id, String filePath) async {
    try {
      print('dellllllllllll $filePath');
      print('dellllllll $id');
      FirebaseFirestore.instance.collection(localSource.type).doc(id).delete();
      await FirebaseStorage.instance.ref(filePath).delete();
      return Right('Deleted file');
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred $error stacktrace:$stacktrace");
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile(File file, String fileName) async {
    try {
      final ref = FirebaseStorage.instance.ref().child("/Fizika/$fileName");
      ref.putFile(file);

      return Right('Deleted file');
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred $error stacktrace:$stacktrace");
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
  @override
  Future<String> takeFileSavePath(String url, {String? addText = ''}) async {
    print("takePath working");
    Directory? directory;
    String newPath = '';
    directory = await getApplicationDocumentsDirectory();
    print(directory?.path.toString());
    final List<String> folders = directory?.path.split("/") ?? [];
    final List<String> folders1 = url.split("/");
    final List<String> folder2 = folders1.last.split(".");
    final String lastPath = "${folder2.first}$addText.${folder2.last}";

    for (int x = 1; x < folders.length; x++) {
      final String folder = folders[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      } else {
        break;
      }
    }


    return "${directory.path}/$lastPath";
    //return "$newPath/Download/$lastPath";
  }
  @override
  Future<bool> saveFile(List<int> bytes, String path) async {
    print('Write 1 working $path');

    final File file = File(path);
    if (!file.existsSync()) {
      print('exist emas');
      file.writeAsBytesSync(
        bytes,
      );
      await OpenFile.open(path);

      return true;
    } else {
      print('exist');

      final String newPath = await takeFileSavePath(path, addText: '(1)');
      return saveFile(bytes, newPath);
    }
  }
  @override
  Future<Either<Failure, String>> downloadFile(String fileName)async {
    try {
      final String url =await  FirebaseStorage.instance.ref().child("/Fizika/$fileName").getDownloadURL();
      print('urrrrrrrrrrrrrrllllllllll${url}');
      final Response<List<int>> response = await Dio().get<List<int>>(url,
          options: Options(
            responseType: ResponseType.bytes,
            receiveTimeout: Duration.zero,
          ), onReceiveProgress: (t, t1) {
            print('downloading...');
            print((t / t1) * 100);
          });

      final String path = await takeFileSavePath(url);
      await saveFile(response.data!, path);

      return Right('Deleted file');
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred $error stacktrace:$stacktrace");
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
}

Future<Map<String, dynamic>?> getDataFile() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final File file1 = File(result.files.single.path!);
    final String fileName1 = file1.path.split("/").last;
    final String path1 = file1.path;

    return {"file": file1, "fileName": fileName1};
  }
  return null;
}
