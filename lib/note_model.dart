class Note {
  int? id;
  String title;
  String desc;

  Note({this.id, required this.title, required this.desc});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
    );
  }
}