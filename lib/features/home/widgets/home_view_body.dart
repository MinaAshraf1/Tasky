import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';
import 'package:to_do_list/features/description/description.dart';
import 'package:to_do_list/features/home/widgets/important_list_view.dart';
import 'package:to_do_list/features/home/widgets/task_item.dart';
import 'package:to_do_list/local_database/sql_db.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool loading = true;
  SqlDb sqlDb = SqlDb();
  List tasks = [];
  List importantTasks = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 50),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),

              const Text(
                "Important Tasks",
                style: Styles.textStyle22,
              ),

              const SizedBox(height: 10,),

              SizedBox(
                  height: 80,
                  child: loading ?
                  const Center(child: CircularProgressIndicator(color: darkGreyColor,))
                      : importantTasks.isEmpty
                      ?const Center(child: Text("There is no important tasks"))
                      : ImportantListView(importantTasks: importantTasks,)
              ),

              const SizedBox(height: 40,),

              const Text(
                "All Tasks",
                style: Styles.textStyle22,
              ),

              const SizedBox(height: 10,),
            ],
          ),

          loading ?
          const Center(child: CircularProgressIndicator(color: darkGreyColor,))
          : tasks.isEmpty
          ?const Center(child: Text("There is no tasks"))
          :ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Description(tasks: tasks[index],),));
                },
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.bottomSlide,
                    title: 'Are you sure?',
                    desc: 'you will remove ${tasks[index]['title']}',
                    btnOkColor: mainColor,
                    btnCancelColor: redColor,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      sqlDb.deleteData(
                        '''
                          DELETE FROM TODO
                          WHERE id = ${tasks[index]["id"]}
                        '''
                      );

                      tasks.removeWhere(
                        (element) => element['id'] == tasks[index]['id']
                      );

                      importantTasks.removeWhere(
                              (element) => element['id'] == importantTasks[index]['id']
                      );
                      setState(() {});
                    },
                  ).show();

                },
                title: tasks[index]['title'],
                description: tasks[index]['description'] == ""? "No Description"
                    : tasks[index]['description'] ?? "No Description",
                complete: tasks[index]['complete'],
              );
            },
          ),
        ],
      ),
    );
  }


  Future<List> getData() async {
    List response = await sqlDb.readData("TODO");
    tasks.addAll(response);
    List response2 = await sqlDb.getData2("important = ?", ["important"]);
    importantTasks.addAll(response2);
    loading = false;
    setState(() {});
    return response;
  }
}