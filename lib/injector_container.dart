// ignore_for_file: avoid_redundant_argument_values
import "dart:developer";
import "dart:io";

import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:flutter/foundation.dart";
import "package:get_it/get_it.dart";
import "package:hive/hive.dart";

import "package:path_provider/path_provider.dart";
import "package:teach/features/profile/presentation/bloc/profile_bloc.dart";

import "core/local_source/local_source.dart";
import "features/api/repository.dart";
import "features/api/repository_impl.dart";
import "features/auth/presentation/bloc/auth_bloc.dart";
import "features/home/presentation/bloc/home_bloc/home_page_bloc.dart";
import "features/main/presentation/bloc/main_bloc.dart";

final GetIt sl = GetIt.instance;
late Box<dynamic> _box;

Future<void> init() async {
  /// External
  await _initHive();
  sl
  //..registerSingleton<LocalSource>(LocalSource(_box))
    .registerSingleton<LocalSource>(LocalSource(_box));
  /// Dio
  sl.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        //"application/json",
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: <String, String>{},
      )

      ..interceptors.add(
        LogInterceptor(
          error: kDebugMode,
          request: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          requestHeader: kDebugMode,
          responseHeader: kDebugMode,
          logPrint: (Object object) {
            if (kDebugMode) {
              log("dio: $object");
            }
          },
        ),
      ),
  );



  /// Core




    /// main
    sl.registerFactory(MainBloc.new);

  /// features
  _authFeature();

}

void _authFeature() {
  /// use cases
  sl

    /// repositories
    ..registerLazySingleton<Repository>(() => RepositoryImpl(dio: sl()))

    /// bloc
    ..registerFactory(() => AuthBloc(authRepository: sl()))
    ..registerFactory(() => HomePageBloc(repository: sl()))
    ..registerFactory(() => ProfileBloc(repository: sl()));


}

Future<void> _initHive() async {
  const String boxName =  "gotix_client_mobile_box";
 final Directory directory = await getApplicationDocumentsDirectory();
 Hive.init(directory.path);
 // Hive.registerAdapter<dynamic>;
  _box = await Hive.openBox<dynamic>(boxName);
}




