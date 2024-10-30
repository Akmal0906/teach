class UserTypeModel {

  UserTypeModel({
    required this.id,
    required this.name,
  });

  factory UserTypeModel.fromJson(Map<String, dynamic> json) => UserTypeModel(
    id: json["id"],
    name: json["name"],
  );
  int id;
  final String name;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
