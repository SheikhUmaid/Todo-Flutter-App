class Todo {
  String id;
  String title;
  String desc;
  bool isDone;

  Todo(
      {required this.title,
      required this.desc,
      required this.isDone,
      required this.id});

  Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      isDone: json['isDone'],
    );
  }
}
