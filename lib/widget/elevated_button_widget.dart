import 'package:flutter/material.dart';
import 'package:todonest/constant/color_constant.dart';

class ElevatedButtonCustomWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  final bool isEnabled;
  const ElevatedButtonCustomWidget(
      {super.key,
      required this.labelText,
      required this.onPressed,
      required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : () {},
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  isEnabled ? ColorGeneral.primary : ColorGeneral.inactive),
          child: Text(
            labelText,
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }
}
