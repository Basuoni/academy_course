
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.color,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  backgroundColor: MaterialStateProperty.all(color),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
