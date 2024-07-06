import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';

class TaskStatus extends StatelessWidget {
  final String taskStatus;
  final String title;
  final void Function(String?)? onChanged;

  const TaskStatus({
    super.key,
    required this.taskStatus,
    this.onChanged,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(title),
      value: "regular",
      groupValue: taskStatus,
      onChanged: onChanged,
      activeColor: mainColor,
    );
  }
}