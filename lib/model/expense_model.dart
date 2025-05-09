import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final String name;
  final int iconCode;
  final String userId;
  final String category;
  final double amount;
  final String createdAt;
  final String type;

  ExpenseModel({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.userId,
    required this.category,
    required this.amount,
    required this.createdAt,
    required this.type,
  });

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'iconCode': iconCode,
      'userId': userId,
      'category': category,
      'createdAt': createdAt,
      'type': type,
    };
  }

  ExpenseModel copyWith({
    String? id,
    String? name,
    int? iconCode,
    String? userId,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCode: iconCode ?? this.iconCode,
      userId: userId ?? this.userId,
      category: category,
      amount: amount,
      createdAt: createdAt,
      type: type,
    );
  }
}
