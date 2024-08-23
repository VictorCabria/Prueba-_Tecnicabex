class NoteModel {
  final int? id;
  final String title;
  final String description;

  NoteModel({this.id, required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
