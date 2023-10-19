import 'package:flutter/material.dart';

class ViewRadioButton extends StatelessWidget {
  final String title;
  final Widget child;
  final bool selected;
  final Function() pressed;
  const ViewRadioButton({required this.title,required this.child,required this.selected,required this.pressed,super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: pressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color:Theme.of(context).canvasColor,
                border:Border.all(
                  color:!selected?Theme.of(context).cardColor:const Color.fromRGBO(111, 111, 198, 1)
                )
              ),
              height:306,
              child:child
            ),
            const SizedBox(height:10),
            Text(
              title,
              style:Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 16
              )
            )
          ],
        ),
      ),
    );
  }
}