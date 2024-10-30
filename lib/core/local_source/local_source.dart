import "package:hive/hive.dart";
import "../../constants/image_constants.dart";

final class LocalSource {
  LocalSource(this.box);

  final Box<dynamic> box;

  bool get hasProfile => box.get(AppKeys.hasProfile, defaultValue: false);

  Future<void> setHasProfile({required bool value}) async {
    await box.put(AppKeys.hasProfile, value);
  }

  Future<void> setEmail(String email) async {
    await box.put(AppKeys.email, email);
  }

  String get email => box.get(AppKeys.email, defaultValue: "");

  Future<void> setPassword(String password) async {
    await box.put(AppKeys.password, password);
  }

  String get password => box.get(AppKeys.password);

  Future<void> setType(String type) async {
    await box.put(AppKeys.type, type);
  }
  String get type => box.get(AppKeys.type,defaultValue: "Student");
  Future<void> setCourse(String course) async {
    await box.put(AppKeys.course, course);
  }
  String? get course => box.get(AppKeys.course);
  Future<void> clear() async {
    await box.clear();
  }
}
