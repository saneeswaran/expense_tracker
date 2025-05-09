import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/util/utils.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseDropDown extends StatefulWidget {
  final String text;
  const ExpenseDropDown({super.key, required this.text});

  @override
  State<ExpenseDropDown> createState() => _ExpenseDropDownState();
}

class _ExpenseDropDownState extends State<ExpenseDropDown> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategory;
  String? type;
  IconData? selectedIcon;

  void submitExpense() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final bool result = await provider.addExpense(
      context: context,
      name: nameController.text,
      amount: double.parse(priceController.text),
      icon: selectedIcon!,
      category: selectedCategory!,
      type: type!,
      createdDate: DateTime.now(),
    );
    if (result && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.07),
        child: Column(
          spacing: size.height * 0.02,
          children: [
            Icon(selectedIcon, size: 60, color: Colors.teal),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Constants.mainColor),
                labelText: "Select Category",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Constants.mainColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Constants.mainColor, width: 2),
                ),
              ),
              value: selectedCategory,
              items:
                  expenseCategories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['name'],
                      child: Text(category['name']),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  selectedIcon =
                      expenseCategories.firstWhere(
                        (cat) => cat['name'] == value,
                      )['icon'];
                });
              },
            ),
            _typeDropDown(),
            CustomTextFormField(controller: nameController, labelText: "title"),
            CustomTextFormField(
              controller: priceController,
              labelText: "Price",
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: CustomElevatedButton(text: widget.text, onPressed: () {}),
            ),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: CustomElevatedButton(
                text: widget.text,
                onPressed: submitExpense,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeDropDown() {
    final items =
        expenseTypes
            .map((type) => DropdownMenuItem(value: type, child: Text(type)))
            .toList();
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Constants.mainColor),
        labelText: "Select Type",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.mainColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.mainColor, width: 2),
        ),
      ),
      items: items,
      onChanged: (String? val) {
        type = val;
      },
    );
  }
}
