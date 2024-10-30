import "dart:io";

import "../../core/either/either.dart";
import "../../core/error/failure.dart";
import "../auth/data/login/login_user_request.dart";

abstract class Repository {
  const Repository();

  Future<Either<Failure, String>> login(LoginUserRequest request);

  Future<Either<Failure, List<Map<String, dynamic>>>> getTasks();

  Future<List<String>?> getFilePath();
  Future<Either<Failure, String>> deleteTasks(String id,String filePath);
  Future<Either<Failure,String>> uploadFile(File file,String fileName);
  Future<Either<Failure, String>> downloadFile(String fileName);
  Future<String> takeFileSavePath(String url, {String? addText = ''});
  Future<bool> saveFile(List<int> bytes, String path);
}
