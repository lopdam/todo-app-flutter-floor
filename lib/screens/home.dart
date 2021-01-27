import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<String> _todos = List<String>();

  BuildContext _context;
  String _input = "";

  @override
  void initState() {
    super.initState();
    _todos.add("Item1");
    _todos.add("Item2");
    _todos.add("Item3");
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      floatingActionButton: _floatingActionButton(),
      body: ListView.builder(
          itemCount: _todos.length,
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
              key: Key(_todos[index]),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(_todos[index]),
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
          }),
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

  void _dismissCard(int index) {
    if (_todos.length > index) {
      setState(() {
        _todos.removeAt(index);
      });
    }
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
                      _todos.add(_input);
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
