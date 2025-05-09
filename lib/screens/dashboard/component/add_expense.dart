import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/screens/dashboard/component/expense_drop_down.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height * 1,
        width: size.width * 1,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.40,
              width: size.width * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Constants.backgroundRectangle),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //form
            _form(size: size),
          ],
        ),
      ),
    );
  }

  Widget _form({required Size size}) {
    return Positioned(
      top: 140,
      left: 40,
      child: Container(
        height: size.height * 0.65,
        width: size.width * 0.80,
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
        child: const Column(
          children: [Expanded(child: ExpenseDropDown(text: "Add"))],
        ),
      ),
    );
  }
}
