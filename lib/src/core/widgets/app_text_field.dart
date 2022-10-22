
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  final TextInputType? type;
  final bool isPassword;
  final VoidCallback? onPressedIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController txtController;

  const AppTextField({
    super.key,
    this.type,
    this.onPressedIcon,
    this.validator,
    this.suffixIcon,
    this.isPassword = false,
    required this.hint,
    required this.prefixIcon,
    required this.txtController,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: SizedBox(
        child: TextFormField(
          keyboardType: type ?? TextInputType.text,
          obscureText: isPassword,
          validator: validator ??
              (it) {
                if (it?.isEmpty == true) return '$hint must not be empty';
                return null;
              },
          controller: txtController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: const TextStyle(color: Colors.grey),

            prefixIcon: Icon(
              prefixIcon,
            ),
            labelText: hint.toString(),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onPressedIcon ?? () {}, icon: Icon(suffixIcon))
                : null,

          ),
        ),
      ),
    );
  }
}
