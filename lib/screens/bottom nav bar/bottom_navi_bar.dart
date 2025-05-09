import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/screens/dashboard/component/add_expense.dart';
import 'package:expense_tracker/screens/dashboard/dashboard_page.dart';
import 'package:expense_tracker/screens/history/history_page.dart';
import 'package:expense_tracker/screens/profile/profile_page.dart';
import 'package:expense_tracker/screens/stats/stats_page.dart';
import 'package:expense_tracker/util/transitions_animation.dart';
import 'package:flutter/material.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int currentIndex = 2;
  final List pages = [
    const DashboardPage(),
    const HistoryPage(),
    const StatsPage(),
    const ProfilePage(),
  ];
  final List<String> label = ["DashBoard", "History", "Stats", "Profile"];
  final List<IconData> icons = [
    Icons.dashboard,
    Icons.history,
    Icons.start,
    Icons.person,
  ];
  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> items = List.generate(
      label.length,
      (index) => BottomNavigationBarItem(
        icon: Icon(icons[index]),
        label: label[index],
      ),
    );
    return Scaffold(
      floatingActionButton:
          currentIndex == 0
              ? FloatingActionButton(
                backgroundColor: Constants.mainColor,
                elevation: 0,
                shape: const CircleBorder(),
                onPressed:
                    () => TransitionsAnimation.moveToNextPageWithDowntoUp(
                      context,
                      route: const AddExpense(),
                    ),
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: items,
        selectedItemColor: Constants.mainColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}
