import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../cubit/cubit.dart';
import '../styles/styles.dart';

// LOGIN BUTTON
Widget loginButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  required VoidCallback function,
  required String text,
  bool isUpper = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

// TEXT FORM FIELD
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required FormFieldValidator<String?> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function(String?)? onSubmitted,
  Function(String?)? onChanged,
  VoidCallback? onTap,
  bool isClickable = true,
  bool isPassword = false,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[300],
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.blue,
        ),
        border: const OutlineInputBorder(),
        prefixIcon: IconSample(
          icon: prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: IconSample(
                  icon: suffix,
                ),
              )
            : null,
      ),
    );

// TEXT FORM FIELD 2
Widget borderlessFormField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required FormFieldValidator<String?> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function(String?)? onSubmitted,
  Function(String?)? onChanged,
  VoidCallback? onTap,
  bool isClickable = true,
  bool isPassword = false,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white70,
        ),
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF49CAF2),
        ),
        prefixIcon: IconSample(
          icon: prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: IconSample(
                  icon: suffix,
                ),
              )
            : null,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF49CAF2),
          ),
        ),
      ),
    );

// TASK CARD
// Widget buildTaskItem(Map model, context) => Dismissible(
//   key: Key(model['id'].toString()),
//   child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         CircleAvatar(
//           radius: 40.0,
//           child: Text(
//               '${model['time']}'
//           ),
//         ),
//
//         const SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${model['title']}',
//                 style: const TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${model['date']}',
//                 style: const TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 20.0,
//         ),
//         IconButton(
//           onPressed: (){
//             AppCubit.get(context).updateData(
//               status: 'done',
//               id: model['id'],
//             );
//           },
//           icon: const Icon(
//             Icons.check_circle_outline_rounded,
//             color: Colors.green,
//           ),
//         ),
//         IconButton(
//           onPressed: (){
//             AppCubit.get(context).updateData(
//               status: 'archived',
//               id: model['id'],
//             );
//           },
//           icon: const Icon(
//             Icons.archive_outlined,
//             color: Colors.black45,
//           ),
//         ),
//       ],
//     ),
//   ),
//   onDismissed: (direction){
//     AppCubit.get(context).deleteData(id: model['id']);
//   },
// );

// UNUSED

Widget buildTaskItemINKWELLTEST(Map model, context) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: InkWell(
                onTap: () {
                  AppCubit.get(context).updateData(
                    status: 'done',
                    id: model['id'],
                  );
                },
                child: model['status'] == 'done'
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      )
                    : const Icon(Icons.circle_outlined, color: Colors.blue),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            InkWell(
              onTap: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              child: Expanded(
                child: Text(
                  model['title'],
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    decoration: model['status'] == 'done'
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget buildTaskItem(Map model, context) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () {
          AppCubit.get(context).updateData(
            status: model['status'] == 'new' ? 'done' : 'new',
            //status: 'done',
            id: model['id'],
          );
        },
        child: Opacity(
          opacity: model['status'] == 'done' ? 0.4 : 1.0,
          child: Container(
            width: double.infinity,
            height: 60.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                ),

                //DONE ICON
                model['status'] == 'done'
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.blue,
                      )
                    : const Icon(Icons.circle_outlined, color: Colors.blue),

                const SizedBox(
                  width: 8.0,
                ),

                Expanded(
                  child: Text(
                    model['title'],
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      decoration: model['status'] == 'done'
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),

                const SizedBox(
                  width: 8.0,
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 16.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: const Color(0xFFffdf00),
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Container(
                        width: 16.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: int.parse(model['priority']) <= 3
                                ? const Color(0xFFffdf00)
                                : Colors.grey[400]),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Container(
                        width: 16.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: int.parse(model['priority']) <= 2
                                ? const Color(0xFFffdf00)
                                : Colors.grey[400]),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Container(
                        width: 16.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: int.parse(model['priority']) == 1
                                ? const Color(0xFFffdf00)
                                : Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

// TASK SCREEN CONDITIONAL BUILDER
Widget taskScreenBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
              ),
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu_rounded,
              size: 100.0,
              color: Colors.blue,
            ),
            Text(
              'No Tasks Yet',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
