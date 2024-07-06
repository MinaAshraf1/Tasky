import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';
import 'package:to_do_list/features/home/widgets/button_float.dart';
import 'package:to_do_list/features/home/widgets/home_view_body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Container(
        //     padding: const EdgeInsets.all(5),
        //     margin: const EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50),
        //       color: whiteColor,
        //     ),
        //     child: Image.asset(Assets.logo, width: 35, fit: BoxFit.fill,)
        // ),
        leading: const Center(child: FaIcon(FontAwesomeIcons.listCheck)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tasky",
              style: Styles.textStyle26.copyWith(color: whiteColor),
            ),

            Text(
              "Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: Styles.textStyle14.copyWith(color: whiteColor),
            ),
          ],
        ),
        leadingWidth: 75,
      ),

      body: const Column(
        children: [
          // CustomAppBar(),

          Expanded(child: HomeViewBody()),
        ],
      ),
      floatingActionButton: const ButtonFloat(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}