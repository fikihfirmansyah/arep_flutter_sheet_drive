import 'package:flutter/material.dart';

class InputFieldRounded extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChange;
  final Widget? suffixIcon;
  final bool secureText;
  final TextInputType keyboardType;
  final String? errortext;
  final FormFieldValidator? validatorCheck;
  const InputFieldRounded(
      {Key? key,
        required this.hint,
        required this.onChange,
        this.validatorCheck,
        this.suffixIcon,
        this.keyboardType = TextInputType.text,
        this.errortext,
        required this.secureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        validator: validatorCheck,
        onChanged: onChange,
        obscureText: secureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: errortext,
          filled: false,
          hintText: hint,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}