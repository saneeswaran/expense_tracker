import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/screens/history/components/expense_history.dart';
import 'package:expense_tracker/screens/history/components/income_history.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.mainColor,
        bottom: TabBar(
          tabs: const [
            Tab(
              child: Text(
                "Income",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Expenses",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [IncomeHistory(), ExpenseHistory()],
      ),
    );
  }
}
