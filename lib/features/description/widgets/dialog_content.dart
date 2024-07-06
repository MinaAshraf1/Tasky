import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';
import 'package:to_do_list/core/widgets/custom_button.dart';
import 'package:to_do_list/core/widgets/custom_text.dart';
import 'package:to_do_list/local_database/sql_db.dart';

class DialogContent extends StatefulWidget {
  final Map tasks;

  const DialogContent({
    super.key,
    required this.tasks,
  });

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String taskStatus;
  late DateTime date;
  late int complete;
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    date = DateTime(0);
    descriptionController.text = widget.tasks['description'];
    titleController.text = widget.tasks['title'];
    taskStatus = widget.tasks['important'];
    date = DateTime.parse(widget.tasks['due_date']);
    complete = widget.tasks['complete'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      color: bageColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20, left: 20, right: 20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const Row(
                children: [
                  Spacer(),
                  Expanded(child: Divider(thickness: 3,)),
                  Spacer(),
                ],
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Update ${widget.tasks['title']}",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle22,
                ),
              ),

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
                      title: const Text("Regular", style: Styles.textStyle14,),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      value: "regular",
                      groupValue: taskStatus,
                      onChanged: (val) {
                        setState(() {
                          taskStatus = "regular";
                        });
                      },
                      activeColor: mainColor,
                    ),
                  ),

                  Expanded(
                    child: RadioListTile(
                      title: const Text("Important", style: Styles.textStyle14,),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      value: "important",
                      groupValue: taskStatus,
                      onChanged: (val) {
                        setState(() {
                          taskStatus = "important";
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

              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Complete",
                  style: Styles.textStyle16,
                  textAlign: TextAlign.start,
                ),
              ),

              Slider(
                inactiveColor: semiBageColor,
                min: 0,
                max: 5,
                value: complete.toDouble(),
                onChanged: (val) {
                  complete = val.toInt();
                  setState(() {
                  });
                },
              ),

              const SizedBox(height: 50,),

              CustomButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()) {
                      sqlDb.updateData(
                        '''
                          UPDATE TODO
                          SET "title" = "${titleController.text}", 
                          "description" = "${descriptionController.text}",
                          "due_date" = "$date",
                          "complete" = $complete,
                          "important" = "$taskStatus"
                          WHERE "id" = ${widget.tasks["id"]}
                        '''
                      );
                      Navigator.of(context).pushReplacementNamed("home");
                    }
                  },
                  name: "Update Task"
              ),
            ],
          ),
        ),
      ),
    );
  }
}