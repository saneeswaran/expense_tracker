import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomElevatedButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey.shade700,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),

      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
