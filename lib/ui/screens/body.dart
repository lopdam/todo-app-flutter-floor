import 'package:flutter/material.dart';
import 'package:todo_app/dao/task_dao.dart';
import 'package:todo_app/db/DB.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/priority.dart';
import 'package:todo_app/values/app_colors.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  TaskDao _taskDao;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    _taskDao = DB.getDBInstance().taskDao;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return StreamBuilder<List<Task>>(
        stream: _taskDao.findAllTasknotDoneStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _cardContainerTask(snapshot.data[index]);
                  });
            } else {
              return Center(
                child: Text("No Tasks"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _cardContainerTask(Task task) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Dismissible(
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            _onDoneTask(task);
          } else {
            _onDeletTask(task);
          }
        },
        key: Key('${task.id}'),
        child: _cardTask(task),
        background: Container(
          color: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerStart,
          child: Icon(
            Icons.done,
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
      ),
    );
  }

  Widget _cardTask(Task task) {
    Color color;

    if (task.priority == Priority.LOW) {
      color = AppColors.low;
    } else if (task.priority == Priority.MEDIUM) {
      color = AppColors.medium;
    } else {
      color = AppColors.high;
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(task.deadline);
    String deadLine =
        "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";

    return ListTile(
      tileColor: color,
      title: Text(
        task.title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.description,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            deadLine,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  void _onDeletTask(Task task) {
    _taskDao
        .deleteTask(task)
        .whenComplete(() => _showSnackBar(title: task.title, action: "Delete"));
  }

  void _onDoneTask(Task task) {
    task.done = true;
    _taskDao
        .updateTask(task)
        .whenComplete(() => _showSnackBar(title: task.title, action: "Done"));
  }

  void _showSnackBar({String title, String action}) {
    Scaffold.of(_context).showSnackBar(
      SnackBar(
        content: Text("Task $title $action"),
      ),
    );
  }
}
