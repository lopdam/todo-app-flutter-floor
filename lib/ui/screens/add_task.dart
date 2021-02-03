import 'package:flutter/material.dart';
import 'package:todo_app/dao/task_dao.dart';
import 'package:todo_app/db/DB.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/priority.dart';
import 'package:todo_app/values/app_colors.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTask createState() => _AddTask();
}

class _AddTask extends State<AddTask> {
  BuildContext _context;
  TaskDao _taskDao;
  TextEditingController _controllerTitle;
  TextEditingController _controllerDescription;
  int _priority;
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _controllerTitle = new TextEditingController();
    _controllerDescription = new TextEditingController();
    _selectedDate = DateTime.now();
    _taskDao = DB.getDBInstance().taskDao;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            _controllerTitle.text = "";
            Navigator.pop(context, true);
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: _onAddTask,
        ),
      ],
      title: Text(
        "Add Task",
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          TextField(
            controller: _controllerTitle,
            decoration:
                InputDecoration(hintText: "Title", alignLabelWithHint: true),
          ),
          TextField(
            controller: _controllerDescription,
            decoration: InputDecoration(
                hintText: "Description", alignLabelWithHint: true),
          ),
          DropdownButton<int>(
            focusColor: Colors.white,
            value: _priority,
            //elevation: 5,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <int>[
              Priority.HIGH,
              Priority.MEDIUM,
              Priority.LOW,
            ].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Center(
                  child: _flag(value),
                ),
              );
            }).toList(),
            hint: Text(
              "Choose Priority",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (int value) {
              setState(() {
                _priority = value;
              });
            },
          ),
          FlatButton(
              onPressed: () => _selectDate(_context),
              child: Text(
                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"))
        ],
      ),
    );
  }

  Widget _flag(int priority) {
    if (priority == Priority.LOW) {
      return Icon(
        Icons.flag,
        color: AppColors.low,
      );
    } else if (priority == Priority.MEDIUM) {
      return Icon(
        Icons.flag,
        color: AppColors.medium,
      );
    } else {
      return Icon(
        Icons.flag,
        color: AppColors.high,
      );
    }
  }

  void _onAddTask() {
    if (_controllerTitle.text.isNotEmpty &&
        _controllerDescription.text.isNotEmpty) {
      _taskDao
          .insertTask(new Task(
              id: null,
              title: _controllerTitle.text,
              description: _controllerDescription.text,
              priority: _priority,
              deadline: _selectedDate.millisecondsSinceEpoch,
              done: false))
          .whenComplete(() => Navigator.pop(context, true));

      _controllerTitle.text = "";
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
}
