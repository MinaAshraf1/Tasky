import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/styles.dart';
import 'package:to_do_list/features/add_task/widgets/add_task_view.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task", style: Styles.textStyle24,),
      ),
      body: const AddTaskView(),
    );
  }

}