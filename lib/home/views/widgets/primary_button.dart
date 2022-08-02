import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color,
  });

  final void Function() onPressed;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: IconButton(
        onPressed: onPressed,
        color: color,
        iconSize: 26,
        highlightColor: Colors.purple.withOpacity(0.2),
        splashColor: Colors.purple.withOpacity(0.2),
        icon: Icon(icon),
      ),
    );
  }
}
