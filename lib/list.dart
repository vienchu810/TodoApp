import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frame1/bloc/todobloc.dart';
import 'package:frame1/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:frame1/event/event_dele.dart';

class list extends StatefulWidget {
  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {
  bool checkbox = false;
  List<todo> taskList = new List();
 // final Todo todo;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<todobloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<todobloc>(
      builder: (context, bloc, child) => StreamBuilder<List<todo>>(
        stream: bloc.todoliststream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        child: ListTile(
                          leading: Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              checkColor: Colors.white,
                              value: checkbox,
                              onChanged: (bool value) {
                                setState(() {
                                  checkbox = value;
                                });
                              }),
                          title: Text(snapshot.data[index].congviec),
                          subtitle: Text(snapshot.data[index].date),
                        ),
                      ),
                      actions: <Widget>[

                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            bloc.event.add(deleeven(snapshot.data[index]));
                          },
                        ),
                      ],
                    );
                  });
            case ConnectionState.none:
            default:
              return Center(
                child: Container(
                  width: 130,
                  height: 100,
                  child: Text('Chưa có công việc nào'),
                ),
              );
          }
        },
      ),
    );
  }

  _selectdatetime(BuildContext context) async {
    DateTime selectdate = DateTime.now();
    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: selectdate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (dateTime != null && dateTime != selectdate)
      setState(() {
        selectdate = dateTime;
      });
  }
}
