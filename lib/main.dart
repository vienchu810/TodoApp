import 'package:flutter/material.dart';
import 'package:frame1/bloc/todobloc.dart';
import 'package:frame1/data/DatabaseHelper.dart';
import 'package:frame1/event/event_add.dart';
import 'package:frame1/model/todo.dart';
import 'package:frame1/list.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:frame1/model/todo.dart';
import 'package:frame1/data/database.dart';

void main() async{
  runApp(MyApp());
 await DatabaseHelper.instance.initDatabase();
}

class MyApp extends StatelessWidget {
  //DatabaseHelper.instance.database;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider<todobloc>.value(
          value: todobloc(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool checkboxvalue = false;
  TextEditingController textController = new TextEditingController();
  int selectedIndex = 0;
  String cv = "";
  String date = "";
  List<todo> taskList = new List();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(width: 5, height: 5),
            Text('Todo list',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Expanded(
              child: list(),
            ),
            Expanded(
              child: Text('Finished list',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.check), title: Text("Checklist")),
          BottomNavigationBarItem(
              icon: Icon(Icons.face), title: Text("Account"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          frame2(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void frame2(BuildContext context) {
    var bloc = Provider.of<todobloc>(context);
    var textcv = TextEditingController();
    var textdate = TextEditingController();

    AlertDialog dialog = AlertDialog(
      title: Text("Todo Jod"),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
      content: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextFormField(
              controller: textcv,
              decoration: InputDecoration(labelText: "Job", helperText: ""),
            )),
            Expanded(
                child: TextFormField(
              controller: textdate,
              decoration: InputDecoration(labelText: "Date", helperText: ""),
            )),
            SizedBox(
              width: 20,
            ),

          ],
        ),
      ),
      actions: [
        ElevatedButton(
            child: Text("Yes "),
            onPressed: () {
              bloc.event.add(addeven(textcv.text,textdate.text));
              Navigator.of(context).pop(false);// Return true
            }),
        ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            }),
      ],
    );
    // Call showDialog function.
    Future<bool> futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
    futureValue.then((value) {
      print("Return value: " + value.toString()); // true/false
    });
  }
//  Future<void> addcv() async {
//    var id = await DatabaseHelper.instance.insert(todo(congviec: cv, date: date));
//    setState(() {
//      taskList.insert(0, todo(id: id, name: cv, dateTime: date));
//    });

}
