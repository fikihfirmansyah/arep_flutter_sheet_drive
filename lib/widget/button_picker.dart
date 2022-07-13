import 'package:flutter/material.dart';

class ButtonPicker extends StatelessWidget {
  const ButtonPicker({Key? key,this.onTap, this.title = "Cover"}) : super(key: key);
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onTap,
      child: Row(
        children: [
          const Icon(
            Icons.camera_alt,
            size: 35,
          ),
          Text(
            title,
            style: const TextStyle( fontSize: 20),
          ),
        ],
      ),
    );
  }
}