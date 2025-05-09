import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateExpense extends StatefulWidget {
  final String expenseId;
  final String title;
  final String amount;
  final IconData icon;
  final String selectedCategory;
  final String type;
  const UpdateExpense({
    super.key,
    required this.expenseId,
    required this.title,
    required this.amount,
    required this.icon,
    required this.selectedCategory,
    required this.type,
  });

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  IconData? selectedIcon;
  String? selectedCategory;
  String? type;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.title;
    priceController.text = widget.amount;
    selectedCategory = widget.selectedCategory;
    type = widget.type;
    selectedIcon = widget.icon;
  }

  void updateExpense() async {
    final date = DateTime.now();
    final formattedDate = DateFormat('dd-mm-yyyy').format(date);
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final bool isSuccess = await provider.updateExpense(
      context: context,
      id: widget.expenseId,
      name: nameController.text,
      iconCode: selectedIcon!.codePoint,
      amount: double.parse(priceController.text),
      createdAt: formattedDate,
      type: type!,
      category: selectedCategory!,
    );
    if (isSuccess && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        height: size.height * 1,
        width: size.width * 1,
        color: Constants.mainColor,
        child: Container(
          height: size.height * 0.40,
          width: size.width * 0.60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(size.width * 0.05),
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
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        width: 2,
                      ),
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
                CustomTextFormField(
                  controller: nameController,
                  labelText: "title",
                ),
                CustomTextFormField(
                  controller: priceController,
                  labelText: "Price",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 1,
                  child: CustomElevatedButton(
                    text: "Update",
                    onPressed: updateExpense,
                  ),
                ),
              ],
            ),
          ),
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
