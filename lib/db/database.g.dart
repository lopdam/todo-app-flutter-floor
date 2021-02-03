// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao _taskDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `description` TEXT, `priority` INTEGER, `deadline` INTEGER, `done` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priority': item.priority,
                  'deadline': item.deadline,
                  'done': item.done == null ? null : (item.done ? 1 : 0)
                },
            changeListener),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priority': item.priority,
                  'deadline': item.deadline,
                  'done': item.done == null ? null : (item.done ? 1 : 0)
                },
            changeListener),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priority': item.priority,
                  'deadline': item.deadline,
                  'done': item.done == null ? null : (item.done ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Stream<List<Task>> findAllTaskStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Task',
        queryableName: 'Task',
        isView: false,
        mapper: (Map<String, dynamic> row) => Task(
            id: row['id'] as int,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            deadline: row['deadline'] as int,
            done: row['done'] == null ? null : (row['done'] as int) != 0));
  }

  @override
  Stream<List<Task>> findAllTasknotDoneStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Task WHERE done=0',
        queryableName: 'Task',
        isView: false,
        mapper: (Map<String, dynamic> row) => Task(
            id: row['id'] as int,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            deadline: row['deadline'] as int,
            done: row['done'] == null ? null : (row['done'] as int) != 0));
  }

  @override
  Future<Task> findTaskById(int id) async {
    return _queryAdapter.query('SELECT * FROM Task WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Task(
            id: row['id'] as int,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            deadline: row['deadline'] as int,
            done: row['done'] == null ? null : (row['done'] as int) != 0));
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(Task person) async {
    await _taskUpdateAdapter.update(person, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}
