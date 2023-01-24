import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.text = '',
    this.iconColor,
  });

  final void Function() onPressed;
  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function(LongPressEndDetails)? onLongPressEnd;
  final IconData? icon;
  final String text;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: Container(
        height: 70,
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color ?? Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: text.isEmpty
            ? Icon(
                icon,
                color: iconColor,
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 26,
                    color: iconColor,
                  ),
                ),
              ),
      ),
    );
  }
}
