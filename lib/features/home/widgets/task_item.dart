import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final int complete;
  final void Function()? onPressed;
  final void Function()? onTap;

  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onTap,
    required this.complete
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: semiBageColor,
          child: ListTile(
            onTap: onTap,
            title: Text(title, style: Styles.textStyle20,),
            subtitle: Text(description, style: Styles.textStyle14,),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                complete == 5
                  ? const FaIcon(FontAwesomeIcons.check, color: greenColor, size: 20,)
                  : Text(
                  "${(complete / 5) * 100} %",
                  style: const TextStyle(color: greenColor),
                ),
                Text("Done", style: Styles.textStyle14.copyWith(color: greenColor),)
              ],
            ),
            trailing: IconButton(
              onPressed: onPressed,
              icon: const FaIcon(FontAwesomeIcons.trash, color: redColor,)
            ),
            textColor:  mainColor,
          ),
        ),

        const SizedBox(height: 10,)
      ],
    );
  }

}