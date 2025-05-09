import 'dart:io';

import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';

class CategoryAlertDialogue extends StatefulWidget {
  const CategoryAlertDialogue({super.key});

  @override
  State<CategoryAlertDialogue> createState() => _CategoryAlertDialogueState();
}

class _CategoryAlertDialogueState extends State<CategoryAlertDialogue> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 1,
        width: size.width * 1,
        color: Constants.mainColor,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            Center(
              child: Container(
                height: size.height * 0.3,
                width: size.width * 0.50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text("Click to add your\n category image"),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.05),
                  height: size.height * 0.30,
                  width: size.width * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    spacing: size.height * 0.02,
                    children: [
                      CustomTextFormField(
                        controller: categoryController,
                        labelText: "category name",
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 1,
                        child: CustomElevatedButton(
                          text: "Add",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
