import 'package:flutter/material.dart';

class Constants {
  static const String onboard = "assets/images/splash.png";
  static const String onboardingBackground =
      "assets/images/splash_background.png";
  static const String backgroundRectangle = "assets/images/Rectangle.png";
  static const Color mainColor = Color.fromRGBO(79, 152, 147, 1);
  static const String profile = "assets/images/profile.jpg";
}

class AppColor {
  static Color darkGreenColor = const Color.fromRGBO(46, 124, 119, 1);
}

List<Map<String, dynamic>> expenseCategories = [
  {'name': 'Food & Drinks', 'icon': Icons.fastfood},
  {'name': 'Transportation', 'icon': Icons.directions_car},
  {'name': 'Utilities', 'icon': Icons.lightbulb},
  {'name': 'Housing', 'icon': Icons.home},
  {'name': 'Health', 'icon': Icons.local_hospital},
  {'name': 'Education', 'icon': Icons.school},
  {'name': 'Entertainment', 'icon': Icons.movie},
  {'name': 'Shopping', 'icon': Icons.shopping_bag},
  {'name': 'Travel', 'icon': Icons.flight},
  {'name': 'Gifts & Donations', 'icon': Icons.card_giftcard},
  {'name': 'Savings', 'icon': Icons.savings},
  {'name': 'Investments', 'icon': Icons.trending_up},
  {'name': 'Loans', 'icon': Icons.request_quote},
  {'name': 'Credit Cards', 'icon': Icons.credit_card},
  {'name': 'Personal Care', 'icon': Icons.spa},
  {'name': 'Pets', 'icon': Icons.pets},
  {'name': 'Insurance', 'icon': Icons.verified_user},
  {'name': 'Others', 'icon': Icons.more_horiz},
];
List<String> expenseTypes = ['Income', 'Expense'];

List<String> profileTiles = ["Invite to Friends", "Profile Settings"];
List<IconData> profileIcon = [Icons.person, Icons.settings];
