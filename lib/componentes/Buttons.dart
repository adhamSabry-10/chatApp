import 'package:flutter/material.dart';
class CustomeButtons extends StatelessWidget {
   CustomeButtons({super.key,  required this.text,this.ontap});
  final String text;
  VoidCallback?ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap,

      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        width: double.infinity,
        height: 65,
        child: Center(child: Text(text)),
      ),
    );
  }
}
