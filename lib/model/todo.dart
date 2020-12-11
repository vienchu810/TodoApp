class todo {
  int _id;
  String _congviec;
  String _date;

  todo.fromData(id, congviec, date) {
    _id = id;
    _congviec = congviec;
    _date = date;
  }

  todo.fromJsonMap(Map<String, dynamic> map)
      : _id = map['id'] as int,
        _congviec = map['congviec'] as String,
        _date = map['date'] as String;

  Map <String, dynamic> toMap() => {
    'id': _id,
    'congviec': _congviec,
    'date': _date
  };

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get congviec => _congviec;

  set congviec(String value) {
    _congviec = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


}
