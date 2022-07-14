import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';

class ButtonRounded extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool invert;
  final bool disabled;

  const ButtonRounded(
      {Key? key,
      this.onPressed,
      required this.text,
      this.invert = false,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
          color: generateMaterialColor(color: Color.fromARGB(255, 15, 57, 35)),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
