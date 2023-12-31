import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

// USING SQFLITE:
// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7. delete from database

class HomeLayout extends StatelessWidget {

  Future<String> getName() async {
    return 'Mado';
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("menu should open");
                  }
                },
                icon: const Icon(
                  Icons.menu_rounded,
                ),
              ),
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            //body: tasks.isEmpty ? const Center(child: CircularProgressIndicator()) : screens[currentIndex],
            body: ConditionalBuilder(
              condition: state is !AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                      priority: priorityController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  keyboard: TextInputType.text,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                    },
                              label: 'Task Title',
                              prefix: Icons.title,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            defaultFormField(
                              controller: timeController,
                              keyboard: TextInputType.datetime,
                              //isClickable: false,
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()
                                ).then((value) {
                                  timeController.text = value!.format(context).toString();
                                  //print(value?.format(context));
                                });
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'time must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            defaultFormField(
                              controller: dateController,
                              keyboard: TextInputType.datetime,
                              //isClickable: false,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-12-30'),
                                ).then((value){
                                  dateController.text = DateFormat.yMMMd().format(value!).toString();
                                  //print(DateFormat.yMMMd().format(value!));
                                });
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'date must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Date',
                              prefix: Icons.date_range_outlined,
                            ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                defaultFormField(
                                  controller: priorityController,
                                  keyboard: TextInputType.number,
                                  //isClickable: false,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'priority must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Priority',
                                  prefix: Icons.low_priority_outlined,
                                ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  ).closed.then((value){
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.add_outlined,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add_task_outlined,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
