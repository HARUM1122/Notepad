import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String note;
  final Function() pressed;
  final Function() onLongPress;
  final bool selected;
  const CustomListTile({
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
      child: SizedBox(
        height:90,
        child:Card(
          shape:selected?RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side:const BorderSide(
              color:Color.fromRGBO(111, 111, 198, 1)
            )
          ):null,
          elevation: 8,
          child:Padding(
            padding:const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width:MediaQuery.of(context).size.width/2,
                  child: Text(
                    title,
                    style:Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize:20,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width:MediaQuery.of(context).size.width/1.3,
                  child: Text(
                    note,
                    style:Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize:16,
                      fontWeight: FontWeight.w400
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}