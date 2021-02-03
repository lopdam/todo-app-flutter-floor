import 'package:flutter/material.dart';
import 'package:todo_app/db/DB.dart';
import 'package:todo_app/ui/screens/home.dart';
import 'package:todo_app/values/app_colors.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  Widget _home;

  @override
  void initState() {
    super.initState();
    _home = Scaffold(
      body: CircularProgressIndicator(),
    );

    DB.initDB().whenComplete(() => setState(() {
          _home = Home();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _home,
    );
  }
}
