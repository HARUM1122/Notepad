import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  final String title;
  final String note;
  final Function() pressed;
  final Function() onLongPress;
  final bool selected;
  const CustomGridTile({
    required this.title, 
    required this.note, 
    required this.pressed,
    required this.onLongPress,
    required this.selected,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap:pressed,
      child:Card(
        shape:selected?RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side:const BorderSide(
            color:Color.fromRGBO(111, 111, 198, 1)
          )
        ):null,
        elevation: 8,
        child:Padding(
          padding:const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height:6),
              Text(
                note,
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:16,
                  fontWeight: FontWeight.w400
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              )
            ],
          ),
        )
      ),
    );
  }
}