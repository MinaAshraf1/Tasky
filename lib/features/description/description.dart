import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';
import 'package:to_do_list/core/widgets/custom_button.dart';
import 'package:to_do_list/core/widgets/custom_text.dart';
import 'package:to_do_list/features/description/widgets/description_view.dart';
import 'package:to_do_list/features/description/widgets/dialog_content.dart';
import 'package:to_do_list/local_database/sql_db.dart';

class Description extends StatefulWidget {
  final Map tasks;

  const Description({super.key, required this.tasks});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  SqlDb sqlDb = SqlDb();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late String taskStatus;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text(widget.tasks['title'], style: Styles.textStyle24,),
        actions: [
          IconButton(
            onPressed: () {
              titleController.text = widget.tasks['title'];
              descriptionController.text = widget.tasks['description'];
              // // _showDialog(context);
              // taskStatus = widget.tasks['important'];
              scaffoldState.currentState!.showBottomSheet(
                (context) => DialogContent(tasks: widget.tasks,)
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DescriptionView(tasks: widget.tasks),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    String taskStatus = widget.tasks['important'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: bageColor,
          title: const  Text("Update Task"),
          titleTextStyle: Styles.textStyle22,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            CustomButton(
                onPressed: (){
                  sqlDb.updateData(
                    '''
                      UPDATE TODO
                      SET "title" = "${titleController.text}", 
                      "description" = "${descriptionController.text}"
                      WHERE "id" = ${widget.tasks["id"]}
                    '''
                  );
                  Navigator.of(context).pushReplacementNamed("home");
                },
                name: "Update Task"
            ),
          ],
          content: SizedBox(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .9,
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          textController: titleController,
                          minLines: 1,
                          maxLines: 1,
                          title: "Title"
                      ),

                      CustomText(
                          textController: descriptionController,
                          minLines: 1,
                          maxLines: 1,
                          title: "Description"
                      ),

                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text("Task Status",
                          style: Styles.textStyle16,
                          textAlign: TextAlign.start,
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text("Regular", style: Styles.textStyle12,),
                              value: "regular",
                              groupValue: taskStatus,
                              onChanged: (val) {
                                taskStatus = "regular";
                                setState(() {

                                });
                              },
                              activeColor: mainColor,
                            ),
                          ),

                          Expanded(
                            child: RadioListTile(
                              title: const Text("Important", style: Styles.textStyle12,),
                              value: "important",
                              groupValue: taskStatus,
                              onChanged: (val) {
                                taskStatus = "important";
                                setState(() {

                                });
                              },
                              activeColor: mainColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}