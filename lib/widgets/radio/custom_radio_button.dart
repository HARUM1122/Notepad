import 'package:flutter/material.dart';
class CustomRadio extends StatelessWidget {
  final String title;
  final Function() pressed;
  final bool selected;
  const CustomRadio({required this.title,required this.pressed, required this.selected,super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:pressed,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width:20,
            height:20,
            padding:const EdgeInsets.all(4),
            decoration:BoxDecoration(
              shape:BoxShape.circle,
              color:selected?const Color.fromRGBO(111, 111, 198, 1):Colors.transparent,
              border:!selected?Border.all(
                color:Colors.grey,
                width:1,
              ):null
            ),
            child:Container(
              decoration: BoxDecoration(
                color:selected?Theme.of(context).canvasColor:Colors.transparent,
                shape:BoxShape.circle
              ),
            )
          ),
          const SizedBox(width:10),
          Text(
            title,
            style:Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize:16,
              fontWeight: FontWeight.w500
            )
          )
        ],
      )
    );
  }
}