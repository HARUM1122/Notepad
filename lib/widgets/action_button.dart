import 'package:flutter/material.dart';
class ActionButton extends StatelessWidget {
  final bool visible;
  final IconData icon;
  final Function() pressed;
  final double size;
  final Color color;
  const ActionButton(
    {
      required this.visible,
      required this.icon, 
      required this.pressed, 
      required this.size,
      required this.color, 
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:visible,
      child: TextButton(
        style:const ButtonStyle(
          overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent)
        ),
        onPressed: pressed,
        child:Icon(
          icon,
          color:color,
          size:size
        )
      ),
    );
  }
}