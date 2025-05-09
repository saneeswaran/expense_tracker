import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeHistory extends StatelessWidget {
  const IncomeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ExpenseProvider>(
        builder: (context, value, child) {
          final income =
              value.filteredExpenses
                  .where((item) => item.type == "Income")
                  .toList();

          return ListView.builder(
            itemCount: income.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Icon(income[index].icon)),
                title: Text(income[index].name),
                subtitle: Text("${income[index].createdAt}"),
                trailing: Text(
                  income[index].amount.toString(),
                  style: const TextStyle(
                    color: Constants.mainColor,
                    fontSize: 18,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
