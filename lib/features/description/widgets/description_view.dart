import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/features/description/widgets/section_text.dart';

class DescriptionView extends StatelessWidget {
  final Map tasks;
  const DescriptionView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionText(data: tasks['description'], title: "Description"),

        const SizedBox(height: 10,),
        const Divider(color: mainColor,),
        const SizedBox(height: 10,),

        SectionText(data: tasks['important'], title: "Task Status"),

        const SizedBox(height: 10,),
        const Divider(color: mainColor,),
        const SizedBox(height: 10,),

        SectionText(
          data: "${DateTime.parse(tasks['due_date']).day} - ${DateTime.parse(tasks['due_date']).month} - ${DateTime.parse(tasks['due_date']).year}",
          title: "Due Date"
        ),

        const SizedBox(height: 10,),
        const Divider(color: mainColor,),
        const SizedBox(height: 10,),

        SectionText(
            data: "${(tasks['complete'] / 5) * 100} %",
            title: "Complete"
        ),
      ],
    );
  }

}