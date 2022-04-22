import 'package:flutter/material.dart';

class OutlinedButtonDesign extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color borderColor;
  final void Function() onPressed;

  const OutlinedButtonDesign({
    required this.width,
    required this.height,
    required this.borderColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1,
            color: borderColor,
          ),
          primary: borderColor,
        ),
      ),
    );
  }
}

class DesignTextButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color color;
  final Color primary;
  final void Function() onPressed;
  final double? elevation;

  const DesignTextButton({
    required this.width,
    required this.height,
    required this.child,
    required this.color,
    required this.primary,
    required this.onPressed,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        child: child,
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: primary,
          elevation: elevation,
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
