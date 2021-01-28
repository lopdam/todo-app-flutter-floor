import 'package:flutter/material.dart';
import 'package:todo_app/dao/task_dao.dart';
import 'package:todo_app/db/DB.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  List<String> _tasks;
  TaskDao _taskDao;

  @override
  void initState() {
    super.initState();
    _taskDao = DB.getDBInstance().taskDao;

    _tasks = List<String>();
    _tasks.add("Item1");
    _tasks.add("Item2");
    _tasks.add("Item3");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              _dismissCard(index);
              String action;
              if (direction == DismissDirection.startToEnd) {
                action = "deleted";
              } else {
                action = "archived";
              }
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Item $index $action"),
                ),
              );
            },
            key: Key(_tasks[index]),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(_tasks[index]),
              ),
            ),
            background: Container(
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Icon(
                Icons.one_k,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  void _dismissCard(int index) {
    if (_tasks.length > index) {
      setState(() {
        _tasks.removeAt(index);
      });
    }
  }
}
