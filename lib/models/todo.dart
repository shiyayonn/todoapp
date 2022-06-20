class Todo {
  int _id;
  bool _isCompleted;
  String _title;
  String _details;
  DateTime _dateCreated;

  int get id => _id;

  bool get isCompleted => _isCompleted;

  String get title => _title;

  String get details => _details;

  DateTime get dateCreated => _dateCreated;

  Todo(this._id, this._isCompleted, this._title, this._details,
      this._dateCreated);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['isCompleted'] = _isCompleted;
    map['title'] = _title;
    map['details'] = _details;
    map['dateCreated'] = _dateCreated;

    return map;
  }

  factory Todo.fromMapObject(Map<String, dynamic> map) {
    return Todo(map["id"], map["isCompleted"], map["title"], map["details"],
        map["dateCreated"]);
  }
}
