import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';

class ButtonFloat extends StatelessWidget {
  const ButtonFloat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addTask");
        },
        backgroundColor: mainColor,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.fileCirclePlus, color: bageColor,),
            const SizedBox(width: 10,),
            Text("Add Task", style: Styles.textStyle16.copyWith(color: bageColor),),
          ],
        ),
      ),
    );
  }

}