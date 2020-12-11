import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:frame1/base/base_event.dart';

abstract class basebloc {
  StreamController<baseevent> _evenstreamController =
      new StreamController<baseevent>();

  Sink<baseevent> get event => _evenstreamController.sink;

  basebloc() {
    //lắng nghe sự kiện từ main
    _evenstreamController.stream.listen((event) {
      if (event is! baseevent) {
        throw Exception('even ko hợp lệ');
      }
      disparcheven(event);
    });
  }

  void disparcheven(baseevent event);

  //khi hàm con extend basebloc overrid dispose tự động call _evenstreamController.close();
  @mustCallSuper
  void dispose() {
    _evenstreamController.close();
  }
}

// TODO Implement this library.
