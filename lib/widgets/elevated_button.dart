import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isGoogleButton;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isGoogleButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(33, 47, 85, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fixedSize: const Size(357, 57),
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      onPressed: onPressed,
      child: Stack(
        children: [
          if (isGoogleButton)
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                'assets/images/google-icon.svg',
                height: 30,
              ),
            ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
