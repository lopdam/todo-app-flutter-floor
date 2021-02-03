import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String title;

  final String description;

  //High:Red, Medium:Orange and Low:Green
  final int priority;

  //Done DateTime
  final int deadline;

  bool done;

  Task(
      {this.id,
      this.title,
      this.description,
      this.priority,
      this.deadline,
      this.done});
}
