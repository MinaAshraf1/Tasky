import 'package:flutter/material.dart';
import 'package:to_do_list/features/description/description.dart';
import 'package:to_do_list/features/home/widgets/important_item.dart';

class ImportantListView extends StatelessWidget {
  final List importantTasks;
  const ImportantListView({super.key, required this.importantTasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 175,
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      itemCount: importantTasks.length,
      itemBuilder: (context, index) {
        return ImportantItem(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Description(tasks: importantTasks[index]),));
          },
          title: importantTasks[index]['title'],
          description: importantTasks[index]['description'] == ""? "No Description"
              : importantTasks[index]['description'] ?? "No Description"
        );
      },

    );
  }

}