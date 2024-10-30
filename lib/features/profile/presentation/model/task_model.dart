class TaskModel {
  final String title;
  final String dateTime;
  final String description;
  final String fileName;
  final String documentId;
  final String path;

  const TaskModel(
      { this.title='',
       this.dateTime='',
       this.description='',
       this.fileName='',
       this.documentId='',
      this.path = ''});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      title: json["title"]??"",
      dateTime: json["dateTime"]??"",
      description: json["description"]??"",
      fileName: json["fileName"]??"",
      documentId: json['documentId']??"",
      path: json['path']??"");

  Map<String, dynamic> toJson() => {
        "title": title,
        "dateTime": dateTime,
        "description": description,
        "fileName": fileName,
        "documentId": documentId,
        "path": path
      };
}
