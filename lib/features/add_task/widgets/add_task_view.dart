import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';
import 'package:to_do_list/core/widgets/custom_button.dart';
import 'package:to_do_list/features/add_task/widgets/custom_text.dart';
import 'package:to_do_list/local_database/sql_db.dart';

class AddTaskView extends StatefulWidget {

  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey();
  SqlDb sqlDb = SqlDb();
  String? taskStatus;
  DateTime date = DateTime.now();

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                textController: titleController,
                minLines: 1,
                maxLines: 1,
                title: "Title",
                validator: (val) {
                  if(val!.isEmpty) {
                    return "Can't send an empty field";
                  }
                  return null;
                },
              ),

              CustomText(
                  textController: descriptionController,
                  minLines: 1,
                  maxLines: 3,
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
                      title: const Text("Regular",),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                      title: const Text("Important",),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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

              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Due Date",
                  style: Styles.textStyle16,
                  textAlign: TextAlign.start,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${date.day} / ${date.month} / ${date.year}",
                      style: Styles.textStyle14,
                    ),

                    IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: date,
                        );

                        if(newDate == null) return;
                        date = newDate;
                        setState(() {});
                      },
                      color: mainColor,
                      icon: const Icon(Icons.date_range),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 50,),

              CustomButton(
                name: "Add Task",
                onPressed: (){
                  if(formKey.currentState!.validate()) {
                    sqlDb.addData(
                      '''
                          INSERT INTO TODO ("title", "description", "important", "due_date")
                          VALUES ("${titleController.text}", "${descriptionController.text}", "$taskStatus", "$date")
                      '''
                    );
                    Navigator.of(context).pushReplacementNamed("home");
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}