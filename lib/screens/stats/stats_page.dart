import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/screens/splash/components/expense_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final double income = provider.totalIncome;
    final double expense = provider.totalExpense;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "Stats",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.40,
              width: size.width * 1,
              child: ExpenseBarChart(income: income, expense: expense),
            ),
          ],
        ),
      ),
    );
  }
}
