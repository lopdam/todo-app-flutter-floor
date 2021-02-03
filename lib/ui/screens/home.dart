import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/add_task.dart';
import 'package:todo_app/ui/screens/body.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  BuildContext _context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      floatingActionButton: _floatingActionButton(),
      body: Body(),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: _onPressFloating,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _onPressFloating() {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AddTask();
        });
  }
}
