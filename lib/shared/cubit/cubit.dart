import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../models/Archived_Tasks/Archived_Tasks_Screen.dart';
import '../../models/Done_Tasks/Done_Tasks_Screen.dart';
import '../../models/New_Tasks/New_Tasks_Screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created successfully');
        database
            .execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT, priority TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error in creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDB(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
    required String priority,
  }) async{
    await database.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status, priority) VALUES("$title", "$date", "$time", "new", "$priority")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDB(database);
      }).catchError((error) {
        print("Error when inserting new record ${error.toString()}");
      });
    });
  }

  void getDataFromDB(database) {
    tasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value){
      //tasks.add(value[value.length-1]);
      value.forEach((element) {
        tasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id
  }) async {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value) {
      getDataFromDB(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id
  }) async {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getDataFromDB(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.add_outlined;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon})
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}