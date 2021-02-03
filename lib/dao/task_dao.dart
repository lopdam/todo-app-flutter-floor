import 'package:floor/floor.dart';
import 'package:todo_app/models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Stream<List<Task>> findAllTaskStream();

  @Query('SELECT * FROM Task WHERE done=0')
  Stream<List<Task>> findAllTasknotDoneStream();

  @Query('SELECT * FROM Task WHERE id = :id')
  Future<Task> findTaskById(int id);

  @insert
  Future<void> insertTask(Task task);

  @delete
  Future<void> deleteTask(Task task);

  @update
  Future<void> updateTask(Task person);
}
