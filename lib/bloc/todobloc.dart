import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frame1/base/base_event.dart';
import 'package:frame1/data/DatabaseHelper.dart';
import 'package:frame1/data/database.dart';
import 'package:frame1/event/event_add.dart';
import 'package:frame1/event/event_dele.dart';
import 'package:frame1/list.dart';
import 'package:frame1/model/todo.dart';
import 'package:frame1/base/base_bloc.dart';
import 'package:frame1/data/DataTable.dart';


class todobloc extends basebloc {
  datatable db = datatable();

  StreamController<List<todo>> _streamController =
      StreamController<List<todo>>();
  var randomID = Random();

  Stream<List<todo>> get todoliststream => _streamController.stream;
  List<todo> tdlist = List<todo>();

  initData() async {
    tdlist = await db.sellectAll();
    if (tdlist == null) {
      return;
    }
    _streamController.sink.add(tdlist);
  }

  _add(todo td) async {
    await db.insert(td);
    tdlist.add(td);
    _streamController.sink.add(tdlist);
  }

  _dele(todo tdo) async {
    await db.delete(tdo);
    tdlist.remove(tdo);
    _streamController.sink.add(tdlist);
  }

  @override
  void disparcheven(baseevent event) {
    // TODO: implement disparcheven
    if (event is addeven) {
      //   todo.fromData(id, congviec, date)
      todo td =
          new todo.fromData(randomID.nextInt(8000), event.congviec, event.date);
      _add(td);
      print(event.congviec);
      print(event.date);
    } else if (event is deleeven) {
      _dele(event.tdo);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }
}
