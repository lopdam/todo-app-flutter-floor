import 'package:flutter/material.dart';
import 'package:todo_app/db/DB.dart';
import 'package:todo_app/screens/body.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  BuildContext _context;
  String _input = "";
  Widget _body;

  @override
  void initState() {
    super.initState();
    _body = CircularProgressIndicator();
    DB.initDB().whenComplete(() => setState(() {
          _body = Body();
        }));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      floatingActionButton: _floatingActionButton(),
      body: _body,
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
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _input = "";
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("Save"),
                onPressed: () {
                  if (_input.isNotEmpty) {
                    setState(() {
                      //_todos.add(_input);
                      _input = "";
                    });
                  }

                  Navigator.pop(context, true);
                },
              ),
            ],
            title: Text("Add TODO List"),
            content: TextField(
              onChanged: (String value) {
                _input = value;
              },
            ),
          );
        });
  }
}
