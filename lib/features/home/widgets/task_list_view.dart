import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/features/description/description.dart';
import 'package:to_do_list/features/home/widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  final List tasks;
  final void Function()? onPressed;

  const TaskListView({super.key, required this.tasks, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const Description(),));
          },
          onPressed: onPressed,
          title: tasks[index]['title'],
          description: tasks[index]['description'] == ""? "No Description"
              : tasks[index]['description'] ?? "No Description",
          complete: tasks[index]['complete'],
        );
      },
    );
  }
}